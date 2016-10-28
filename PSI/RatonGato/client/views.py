from django.shortcuts import render
from forms import LoginForm
from forms import RegisterForm
from django.http import HttpResponse
from django.shortcuts import render_to_response
from django.template import RequestContext

base_url = 'http://127.0.0.1:8000/server/api/v1/user/'
import urllib2,urllib,json#requests


def powersOfTwo(x):
    """decompose a number in powers of 2
    """
    powers = []
    exponents = []
    i = 1
    exponent = 0
    while i <= x:
        if i & x:
            powers.append(i)
            exponents.append(exponent)
        i <<= 1
        exponent +=1
    return powers,exponents

def confirmRegister(request):
    return HttpResponse("Server says user registered")
#
#def confirmLogin(request):
#    return HttpResponse("Server says user loged")

def game(request):
    return HttpResponse("I am in game")

message = None
cookie = None
def connect(full_url, values):
    """I am being lazzy and using values for two different purposes
       pass information to connect function and pass information to webserver.
       In the real application this should not be done
       """
    global cookie
    try:
        request = urllib2.Request(full_url, urllib.urlencode(values))
    except urllib2.HTTPError, e:
        print "HTTP error: %d" % e.code
    except urllib2.URLError, e:
        print "Network error: %s" % e.reason.args[1]
    if cookie:
        print("set Cookie")
        request.add_header('cookie', cookie)
    try:
        raw = urllib2.urlopen(request)
        #If you want to keep the authentication you need to reuse the cookie.
        cookieAux = raw.headers.get('Set-Cookie')
        if cookieAux is not None:
            cookie=cookieAux
        js = raw.readlines()
        #decode reply to a dictionary
        js_object = json.loads(js[0])
        print("js_object",js_object)
#        #check if result ok
#        if js_object['result']:
#            print((values['success_message']+"%d")%js_object['value'])
#        else:
#            print("ERROR: %s"%js_object['message'])
    except urllib2.HTTPError as e:
#        cookie=None
        print e.read()#handler.read()
    return js_object


def register(request):
    # A HTTP POST?
    if request.method == 'POST':
        form = RegisterForm(request.POST)

        # Have we been provided with a valid form?
        if form.is_valid():
            # Save the new category to the database.
            function = "add_user/" #do not forget the trailing slash
            full_url = base_url + function
            values={}
            values['username'] = form.cleaned_data['username']
            values['password'] = form.cleaned_data['password']
            resultDic = connect(full_url, values)
            template = "client/login.html"#as soon as registered go to game
            if resultDic['result']:
                    form = LoginForm()
                    return render(request, 'client/login.html', {'form': form,"message":message})

            else:
                form.add_error("username","Could not register username = %s"%values['username'])
        else:
            # The supplied form contained errors - just print them to the terminal.
            print form.errors
    else:
        # If the request was not a POST, display the form to enter details.
        form = RegisterForm()

    # Bad form (or form details), no form supplied...
    # Render the form with error messages (if any).
    return render(request, 'client/register.html', {'form': form,"message":message})

def login(request):
    # A HTTP POST?

    if request.method == 'POST':
        form = LoginForm(request.POST)

        # Have we been provided with a valid form?
        if form.is_valid():
            # Save the new category to the database.
            function = "login_user/" #do not forget the trailing slash
            full_url = base_url + function
            values={}
            values['username'] = form.cleaned_data['username']
            values['password'] = form.cleaned_data['password']
            values['amicat'] = form.cleaned_data['amicat']
            resultDic = connect(full_url, values)
            template = "client/game.html"
            #depending on the value of amIcat
            #we should create a new game or init one
            if resultDic['result'] and resultDic['value']!=-1:

                if  values['amicat'] == True:
                    function = "add_game/" #do not forget the trailing slash
                    full_url = base_url + function
                    resultDic = connect(full_url, values)
                    if  resultDic['result'] and resultDic['value']!=-1 :
                       return render(request
                              ,template
                              ,context={'username': values['username']}
                              ,context_instance=RequestContext(request))
                    else:
                         form.add_error("username","Failed to add game")
                else:
                    function = "join_game/" #do not forget the trailing slash
                    full_url = base_url + function
                    resultDic = connect(full_url, values)
                    if resultDic['result'] and resultDic['value']!=-1 :
                       return render(request
                              ,template
                              ,context={'username': values['username']}
                              ,context_instance=RequestContext(request))
                    else:
                         form.add_error("username","Failed to join game")
            else:
                form.add_error("username","Wrong username or password")
        else:
            # The supplied form contained errors - just print them to the terminal.
            print form.errors
    else:
        # If the request was not a POST, display the form to enter details.
        form = LoginForm()

    # Bad form (or form details), no form supplied...
    # Render the form with error messages (if any).
    return render(request, 'client/login.html', {'form': form,"message":message})

def logout(request):
    function = "logout/" #do not forget the trailing slash
    full_url = base_url + function
    values={}
    #resultDic = connect(full_url, values)
    form = LoginForm()
    return render(request, 'client/login.html', {'form': form,"message":message})


#instead of counting number of call we should cal to status
#and render the board here. Consider using powerofTwo
def counter(request):
    function = "status/"
    full_url = base_url + function
    values = {}
    board = ["."for i in range(64)]
    values["type"] = "cats"
    resultDic = connect(full_url,values)
    posiciones=powersOfTwo(resultDic['value'])
    for pos in posiciones[1]:
        board[pos]="g"

    values["type"] ="mouse"
    resultDic = connect(full_url,values)
    posiciones=powersOfTwo(resultDic['value'])
    for pos in posiciones[1]:
        board[pos]="m"

    if request.is_ajax():
        template = "client/game_ajax.html"
    else:
        template = "client/game.html"
    return render_to_response(template,
                              {'board': board},
                              context_instance=RequestContext(request))

def move(request):
    function = "move/"
    full_url = base_url + function
    values = {}
    values['click'] = request.GET['click']
    print("views.move", values['click'])
    resultDic = connect(full_url,values)
    return counter(request)