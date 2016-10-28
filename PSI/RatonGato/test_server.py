# The meat of the operation
base_url = 'http://127.0.0.1:8000/server/api/v1/user/'
import urllib2, urllib,sys
import json
usernameCat   = 'catUser'
passwordCat   = 'cat'
usernameMouse = 'mouseUser'
passwordMouse = 'mouse'
cookieCat = None
cookieMouse = None

def connect(full_url, values):
    """I am being lazzy and using values for two different purposes
       pass information to connect function and pass information to webserver.
       In the real application this should not be done
       """
    request = urllib2.Request(full_url, urllib.urlencode(values))
    if 'cookie' in values:
        print("set Cookie")
        request.add_header('cookie', values['cookie'])
    try:
        raw = urllib2.urlopen(request)
        #If you want to keep the authentication you need to reuse the cookie.
        cookie = raw.headers.get('Set-Cookie')
        js = raw.readlines()
        #decode reply to a dictionary
        js_object = json.loads(js[0])
        #check if result ok
        if js_object['result']:
            print((values['success_message']+"%d")%js_object['value'])
        else:
            print("ERROR: %s"%js_object['message'])
    except urllib2.HTTPError as e:
        cookie=None
        print e.read()#handler.read()
    return js_object, cookie

def addUser():
    function = "add_user/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['username'] = usernameCat
    values['password'] = passwordCat
    values['success_message'] = "User %s created succesfully with id="%(usernameCat)
    full_url = base_url + function
    js_object, cookie = connect(full_url,values)
    #cookieCat = cookie
    #create mouse user
    values['username'] = usernameMouse
    values['password'] = passwordMouse
    full_url = base_url + function
    js_object, cookie = connect(full_url,values)
    #cookieMouse = cookie

def logUser():
    global cookieCat, cookieMouse
    function = "login_user/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['username'] = usernameCat
    values['password'] = passwordCat
    values['success_message'] = "User %s loged succesfully with id="%(usernameCat)
    full_url = base_url + function
    js_object, cookieCat = connect(full_url,values)
    #create mouse user
    values['username'] = usernameMouse
    values['password'] = passwordMouse
    values['success_message'] = "User %s loged succesfully with id="%(usernameMouse)
    full_url = base_url + function
    js_object, cookieMouse = connect(full_url,values)

def addGame():
    function = "add_game/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['success_message'] = "Game created successfully with id="
    values['cookie']=cookieCat
    full_url = base_url + function
    js_object, dummyCookie = connect(full_url,values)

def counter():
    function = "counter/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['success_message'] = "counter="
    full_url = base_url + function
    request,cookie = connect(full_url,values)
    values['cookie']=cookie
    connect(full_url,values)
    connect(full_url,values)
    connect(full_url,values)
    connect(full_url,values)

def clean_orphan_games():
    function = "clean_orphan_games/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['success_message'] = "number of games cleaned="
    full_url = base_url + function
    js_object,cookie = connect(full_url,values)

def joinGame():
    function = "join_game/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['success_message'] = "Game joined with id="
    values['cookie']=cookieMouse
    full_url = base_url + function
    js_object, dummyCookie = connect(full_url,values)

def catMove(click):
    #El tercer gato pasa de (8,3) a (7,3))
    function = "move/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['success_message'] = "Cat move stored with id="
    values['cookie']=cookieCat
    values['click'] = click
    #values['target'] = target
    full_url = base_url + function
    js_object, dummyCookie = connect(full_url,values)

def mouseMove(click):
    function = "move/" #do not forget the trailing slash
    values = {}
    #create cat user
    values['success_message'] = "Mouse move stored with id="
    values['cookie']=cookieMouse
    values['click'] = click
    full_url = base_url + function
    js_object, dummyCookie = connect(full_url,values)

def status(type,cookie):
    function = "status/" #do not forget the trailing slash
    values = {}
    #check
    if type == 'cats':
        values['success_message'] = "cats board:"
    elif type == 'mouse':
        values['success_message'] = "mouse board:"
    else:
        values['success_message'] = "turn (-1-> not my turm , 1-> myturn) ="
    values['cookie']=cookie
    values['type'] = type
    full_url = base_url + function
    js_object, dummyCookie = connect(full_url,values)
    if js_object['value'] is not None:
        printBoard(js_object['value'])

def printBoard(board):
    def rev(s): return s[::-1]
    s = " "
    for col in range (0,64):
        if (board&(1<<col))!=0:
            s += "1 "
        else:
            s += "0 "
        if (col + 1)  % 8 ==0:
            print(str(1 + col/8) + s)
            s=" "
    s="  1 2 3 4 5 6 7 8\n"
    print(s)


# Start execution here!
if __name__ == '__main__':

    try:
        import sqlite3
        conn = sqlite3.connect('/home/roberto/Docencia/PSI/2015-16/Code/Practica3/ratonGato/db.sqlite3')
        c = conn.cursor()
        c.execute("delete from server_move")
        c.execute("delete from server_game")
        c.execute("delete from server_user")
        # Save (commit) the changes
        conn.commit()
        # We can also close the connection if we are done with it.
        # Just be sure any changes have been committed or they will be lost.
        conn.close()
    except:
        pass

    addUser()
    counter()
    logUser()
    clean_orphan_games()
    addGame()
    joinGame()
    status("cats",cookieCat)
    #catPlace= 2**(8*6+1)#(row=7,col=2) 2**(8*(row-1)+(col-1))
                                  # v = int(math.log(catPlace,2))
                                  #(row,col)=(v/8+1,v%8+1)
    origin, target = 59,52
    catMove(origin)
    catMove(target)
    status("cats",cookieCat)
    #mousePlace= 2**(8*1+2)#(row=2,col=3)
    origin, target = 4,11
    mouseMove(target)#only target is needed
    status("mouse",cookieMouse)
    #exit()
    print('cat tries to move to a wrong place')
    print('this must be give an error')
    origin, target = 51, 12
    catMove(origin)
    catMove(target)
    print ('cat correct movement')
    origin, target = 52,43
    catMove(origin)
    catMove(target)
    status("cats",cookieCat)
    status("mouse",cookieMouse)
    print("-1-> not my turm , 1-> myturn")
    print("Since cat has moved last")
    print("myTurn should be 1 for mouse and -1 for cat")
    status("myTurn",cookieCat)#this should be -1
    status("myTurn",cookieMouse)#this should be +1

