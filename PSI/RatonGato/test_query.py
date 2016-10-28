__author__ = 'e280671'
import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'RatonGato.settings')

import django
django.setup()

from server.models import User, Game, Move

def query():

    id=10
    username='u10'
    password='p10'
    u = User.objects.filter(id=id)

    if u.exists():
        u10 = u[0]
        print("El usuario con id = %d ya existe"%id)
    else:
        u10=User(id=id,password=password,userName=username)
        u10.save()

    id=11
    username='u11'
    password='p11'
    u = User.objects.filter(id=id)

    if u.exists():
        u11 = u[0]
        print("El usuario con id = %d ya existe"%id)
    else:
        u11=User(id=id,password=password,userName=username)
        u11.save()

    g1=Game(catUser=u10)
    g1.save()
    id_game=g1.id

    games=Game.objects.filter(mouseUser__isnull=True)

    if games.exists():
        game=games[0]
        game.mouseUser=u11
        game.save()
        print("Existe un juego vacio")
    else:
         print("No existe ningun juego con un usuario vacio")
         exit()

    cat=game.catUser

    if cat.id==10:
        move=Move(game=game,origin=59,target=52)
        move.save()
        print("Cat se mueve",move.id)


    mouse=game.mouseUser

    if mouse.id==11:
        move2=Move(game=game,origin=4,target=11)
        move2.save()
        print("Mouse se mueve")


if __name__ == '__main__':
    print "Start test query script"
    query()