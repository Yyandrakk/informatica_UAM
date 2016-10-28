#import pycurl
import json
import os
import cookielib

usernameCat   = 'c'
passwordCat   = 'c'
usernameMouse = 'm'
passwordMouse = 'm'
cookieCat = "cat.txt"
cookieMouse = "mouse.txt"
tokenCat=None
tokeMouse=None
base_url8000 = 'http://127.0.0.1:8000/client/'
base_url8001 = 'http://127.0.0.1:8001/client/'
function = "login/" #do not forget the trailing slash
#curl = pycurl.Curl()
CURL = "/usr/bin/curl"
def connectPOST(function, base_url, values ):

    # read cookies
    if values['amicat'] :
        COOKIEFILE = cookieCat
    else:
        COOKIEFILE = cookieMouse
    cj = cookielib.MozillaCookieJar(COOKIEFILE)
    cj.load()
    s='"'
    cookie = cj._cookies['127.0.0.1']['/']['csrftoken'].value
    for key,value in values.iteritems():
        s += key + "=" + str(value) + "&"
    s += "csrfmiddlewaretoken=" + cookie + '"'
#    command = "curl -v -c %s -b %s -d \"username=a&password=a&amicat=True&csrfmiddlewaretoken=%s\" %s"%(COOKIEFILE,COOKIEFILE,cookie, base_url + function)
    command = "%s -v -b %s -d %s %s"% (CURL, COOKIEFILE, s, base_url + function)
    print command
    os.system(command)
#curl -v -c cookies1.txt -b cookies1.txt -d "username=a&password=a&amicat=True&csrfmiddlewaretoken=0NzYhL2kn8sPfM3XSXZPqmRgzr6E3PM9" http://127.0.0.1:8000/client/login


#clean data base
def connectGET(function,base_url, values=None):
    # Login
    if values['amicat'] :
        COOKIEJAR = cookieCat
    else:
        COOKIEJAR = cookieMouse
    print("COOKIEJAR,COOKIEJAR")
    command = "%s -v -c %s  -b %s %s"%(CURL, COOKIEJAR,COOKIEJAR,base_url + function)
    #import urllib
    #parameters = urllib.urlencode({'param1':'7', 'param2':'seven'})
    s="?"
    if len(values) > 1:
        if values is not None:
            for key,value in values.iteritems():
                if key == 'amicat':
                    pass
                else:
                    s += key + "=" + str(value)
        command +=s
    print("command",command, "cwd",os.getcwd() )

    os.system(command)
    #curl -v -c cookies1.txt http://127.0.0.1:8000/client/login/origin=1&target=11

try:
    import sqlite3
    conn = sqlite3.connect('db.sqlite3')
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


values = {}
#get cookies  using get
#create users
#cat
values['amicat']   = True
connectGET('register/',base_url8000,values)
values['username'] = usernameCat
values['password'] = passwordCat
connectPOST('register/',base_url8000,values)
#mouse
values['amicat']   = False
connectGET('register/',base_url8001,values)
values['username'] = usernameMouse
values['password'] = passwordMouse
connectPOST('register/',base_url8001, values)
#exit(1)

#get cookies for  cat and then login
values['amicat']   = True
connectGET('login/',base_url8000, values)
values['username'] = usernameCat
values['password'] = passwordCat
connectPOST('login/',base_url8000,values)

#get cookies for mouse and then login
del values['username']
del values['password']
values['amicat']   = False
connectGET('login/',base_url8001,values)
#login cmouse
values['username'] = usernameMouse
values['password'] = passwordMouse
connectPOST('login/',base_url8001,values)



#make cat move_1
del values['username']
del values['password']
values['amicat']   = True
values['click'] = 59
connectGET('move/',base_url8000 ,values)
values['click'] = 52
connectGET('move/',base_url8000 ,values)



#make mouse move_2
values['amicat']   = False
#values['origin'] = 4
values['click'] = 11
connectGET('move/',base_url8001 ,values)

#make cat move<- fail
values['amicat']   = True
values['click'] = 52
connectGET('move/',base_url8000 ,values)
values['click'] = 43
connectGET('move/',base_url8000 ,values)


#make mouse move
values['amicat']   = False
#values['origin'] = 11
values['click'] = 20
connectGET('move/',base_url8001 ,values)
exit(1)