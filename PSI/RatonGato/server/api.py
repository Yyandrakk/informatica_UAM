#Fichero llamado api.py situado en directorio server
#la clase tastypie implementa los webservices
from tastypie.resources import ModelResource, ALL
from models import User, Game, Move # clase donde se almacenan los usuarios del sistema
from django.conf.urls import url
from tastypie.utils import trailing_slash

def isValidCatMove(self, cm,  origin, target):
        #bitwise comparison,
        game = cm
        if (game.cat1 == target or
            game.cat2 == target or
            game.cat3 == target or
            game.cat4 == target or
            game.mouse == target):
              return False
        if not (game.cat1 == origin or
                game.cat2 == origin or
                game.cat3 == origin or
                game.cat4 == origin ):
            return False

        if not ((origin-7)==target or (origin-9)==target):
            return False
        #must be your turn
        if game.catTurn == -1:
                return False

        return True
def isValidMouseMove(self, cm, target):
    game=cm
    origin=game.mouse
    if (game.cat1 == target or
            game.cat2 == target or
            game.cat3 == target or
            game.cat4 == target or game.mouse == target):
        return False
    if not ((origin-7)==target or (origin-9)==target or (origin+7)==target or (origin+9)==target):
        return False
    if game.catTurn == 1:
        return False
    return True

class UserResource(ModelResource):
    """good for search http://127.0.0.1:8000/server/api/user/?id=111&format=json"""

    class Meta:
        queryset = User.objects.all()
        # Este resorce -conjunto de webservices- se identifica con la etiqueta user
        resource_name = 'user'
        #las siguientes lineas no son relevantes para nuestro juego
        #informan al servidor de que autorice
        #busquedas tanto por id como por username
        filtering = {
            'id': ALL,
            'userName': ALL
        }

        #agnade al mapeo de urls los webservices que desarrolleis
    def prepend_urls(self):
        return [
            url(r"^(%s)/add_user%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('add_user'), name="api_add_user"),
            url(r"^(%s)/counter%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('counter'), name="api_counter"),
            url(r"^(%s)/login_user%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('login_user'), name="api_login_user"),
            url(r"^(%s)/add_game%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('add_game'), name="api_add_game"),
            url(r"^(%s)/clean_orphan_games%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('clean_orphan_games'), name="api_clean_orphan_games"),
            url(r"^(%s)/join_game%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('join_game'), name="api_join_game"),
            url(r"^(%s)/status%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('status'), name="api_status"),
            url(r"^(%s)/move%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('move'), name="api_move"),
             url(r"^(%s)/logout%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('logout'), name="api_logout"),
        ]

    def add_user(self, request, *args, **kwargs):
        """para probar el web service podeis ejecutar cualquiera de los comandos siguientes"""
        """http://127.0.0.1:8000/server/api/v1/user/add_user/?username=perico&password=felices&format=json"""
        """curl  -i -d "username=u1&password=p1"  http://127.0.0.1:8000/server/api/v1/user/add_user/"""
        statsDict = {}
        username = request.POST['username']
        password = request.POST['password']
        try:
            #crea un usuario nuevo 
            u = User(password=password, userName=username)
            #persistilo en la base de datos
            u.save()
            #rellena el diccionario que sera devuelto a la aplicacion
            #seria mas comodo devolver el usuario en lugar del id
            #pero la serializacion de objetos no suele funcionar bien
            statsDict['value'] = u.id
            statsDict['result'] = True
            statsDict['message'] = "userId"
        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False
        #guardar el identificador de usuario en una variable de session
        #request.session['userId'] =u.id
        #recuperar el identificador de usuario de una variable de sesion
        #id = request.session['userId']
        #recordad que para usar las variable de session hace falta 
        #activas las cookies como se muestra en el script test_server.py
        #comprobar si variable 'counter' esta guardada en session
        #if 'counter' in request.session:
        return self.create_response(request, statsDict)

    def counter(self, request, *args, **kwargs):
       statsDict = {}
       try:
           if not 'contador' in request.session:
             request.session['contador']=0

           request.session['contador']=request.session['contador']+1
           statsDict['value'] =request.session['contador']
           statsDict['result'] = True
           statsDict['message'] = "counter"
       except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False

       return self.create_response(request, statsDict)

    def login_user(self, request, *args, **kwargs):
        statsDict = {}
        username = request.POST['username']
        password = request.POST['password']

        try:
            u=User.objects.filter(userName=username , password=password)
            if u.exists():
                request.session['userId'] =u[0].id
                statsDict['value'] = u[0].id
                statsDict['result'] = True
                statsDict['message'] = "userId"
            else:
                statsDict['value'] = -1
                statsDict['result'] = True
                statsDict['message'] = "noUserId"

        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False
        return self.create_response(request, statsDict)

    def add_game(self, request, *args, **kwargs):

        statsDict = {}

        try:
            if 'userId' in request.session:
                uid=request.session['userId']
                u=User.objects.filter(id=uid)
                g1=Game(catUser=u[0])
                g1.catTurn=1
                g1.save()
                request.session['gameId']=g1.id
                request.session['AmICat']=1
                statsDict['value'] = g1.id
                statsDict['result'] = True
                statsDict['message'] = "gameId"
            else:
                statsDict['value'] = -1
                statsDict['result'] = True
                statsDict['message'] = "noGameId"
        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False

        return self.create_response(request, statsDict)

    def clean_orphan_games(self, request, *args, **kwargs):

        statsDict = {}

        try:
            games=Game.objects.filter(mouseUser__isnull=True)
            if(games.exists()):
                statsDict['value'] = games.count()
                games.delete()
            else:
                statsDict['value'] =0


            statsDict['result'] = True
            statsDict['message'] = "gamesOrphanDelete"

        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False

        return self.create_response(request, statsDict)

    def join_game(self, request, *args, **kwargs):

        statsDict = {}
        uid=request.session['userId']

        try:
            games=Game.objects.filter(mouseUser__isnull=True)
            statsDict['value']=-1
            statsDict['message'] = "noJoinGame"
            statsDict['result'] = True
            us=User.objects.filter(id=uid)
            u=us[0]
            if(games.exists()):
                for game in  games:
                    if(game.catUser!=u):
                        game.mouseUser=u
                        game.save()
                        request.session['gameId']=game.id
                        statsDict['value']=game.id
                        statsDict['message'] = "joinGame"
                        request.session['AmICat']=0
                        break

        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False


        return self.create_response(request, statsDict)


    #No anadida arriba a lo de url
    def cat_move(self, request, *args, **kwargs):
        gameId=request.session['gameId']
        pos=int(request.POST['click'])
        statsDict = {}

        try:

            if 'statusCat' in request.session and request.session['statusCat']!=-1:
                print("create move (cat)")
                games = Game.objects.filter(id=gameId)
                g=games[0]
                if(isValidCatMove(self, g, request.session['statusCat'] , pos)==True):
                    move=Move(game=g,origin=request.session['statusCat'],target=pos)
                    move.save()
                    print("move", move)
                    statsDict['message'] = "Movimiento realizado"
                    statsDict['value'] = move.id
                    statsDict['result'] = True
                    if(g.cat1==request.session['statusCat']):
                        g.cat1=pos
                    elif(g.cat2==request.session['statusCat']):
                        g.cat2=pos
                    elif(g.cat3==request.session['statusCat']):
                        g.cat3=pos
                    else:
                       g.cat4=pos
                    g.catTurn=-1
                    g.save()
                else:
                    print("error creating move")
                    statsDict['message'] = "Movimiento no realizado"
                    statsDict['value'] = -1
                    statsDict['result'] = True

                request.session['statusCat']=-1

            else:
                 request.session['statusCat']=pos
                 statsDict['message'] = "origin"
                 statsDict['value'] = pos
                 statsDict['result'] = True
        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False


        return self.create_response(request, statsDict)

    def mouse_move(self, request, *args, **kwargs):
        gameId=request.session['gameId']
        statsDict = {}
        pos=int(request.POST['click'])
        try:
            games = Game.objects.filter(id=gameId)
            g=games[0]
            if isValidMouseMove(self, g , pos):
                move= Move(game=g,origin=g.mouse,target=pos)
                move.save()
                statsDict['message'] = "Movimiento realizado"
                statsDict['value'] =move.id
                statsDict['result'] = True
                g.mouse=pos
                g.catTurn=1
                g.save()
            else:
                statsDict['message'] = "Movimiento no realizado"
                statsDict['value'] = -1
                statsDict['result'] = True
        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False

        return self.create_response(request, statsDict)

    def move(self, request, *args, **kwargs):
        statsDict = {}
        print("move",request.session['gameId'])
        gameId=request.session['gameId']
        try:
            games = Game.objects.filter(id=gameId)
            if(games[0].catTurn==1 and request.session['AmICat']==1 ):
               return self.cat_move( request, *args, **kwargs)
            elif(games[0].catTurn==-1 and request.session['AmICat']==0):
               return self.mouse_move( request, *args, **kwargs)
        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False

        return self.create_response(request, statsDict)

    def status(self, request, *args, **kwargs):
        statsDict = {}
        gameId=request.session['gameId']
        type=request.POST['type']
        try:
            games = Game.objects.filter(id=gameId)
            g = games[0]
            if(type == "cats"):
                    statsDict['message'] = "Gato"
                    statsDict['value'] = 2**g.cat1 | 2**g.cat2 | 2**g.cat3 | 2**g.cat4
                    statsDict['result'] = True
            elif (type =="mouse"):
                    statsDict['message'] = "Raton"
                    statsDict['value'] = 2**g.mouse
                    statsDict['result'] = True
            elif (type == "myTurn"):
                    statsDict['message'] = "Turno"
                    if(request.session['AmICat']==1 and g.catTurn==1 ):
                        statsDict['value'] = g.catTurn
                    elif (request.session['AmICat']==0 and g.catTurn==-1 ):
                         statsDict['value'] = 1
                    else:
                        statsDict['value']=-1
                    statsDict['result'] = True
        except Exception as e:
            #en caso de error reportalo
            statsDict['message'] = e.message
            statsDict['value'] = -1
            statsDict['result'] = False


        return self.create_response(request, statsDict)

    def logout(self, request, *args, **kwargs):
            statsDict = {}

            try:
                for key in request.session.keys():
                    del request.session[key]
                statsDict['message'] = "Log out exitoso"
                statsDict['value'] = 1
                statsDict['result'] = True
            except Exception as e:
                #en caso de error reportalo
                statsDict['message'] = e.message
                statsDict['value'] = -1
                statsDict['result'] = False


            return self.create_response(request, statsDict)