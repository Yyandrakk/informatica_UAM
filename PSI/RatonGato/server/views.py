from django.shortcuts import render
from forms import add_user, login
from django.http import HttpResponse
from models import User

def validRegister(request):
    return HttpResponse("Registro valido")


def register(request):
    # A HTTP POST?
    if request.method == 'POST':
        form = add_user(request.POST)

        # Have we been provided with a valid form?
        if form.is_valid():
            # Save the new category to the database.
            form.save(commit=True)

            # Now call the index() view.
            # The user will be shown the homepage.
            return validRegister(request)
        else:
            # The supplied form contained errors - just print them to the terminal.
            print form.errors
    else:
        # If the request was not a POST, display the form to enter details.
        form = add_user()

    # Bad form (or form details), no form supplied...
    # Render the form with error messages (if any).
    return render(request, 'server/register.html', {'form': form})

def validLogin(request):
    return HttpResponse("Log in valido")


def log_in(request):
    # A HTTP POST?
    if request.method == 'POST':
        user_name=request.POST.get("userName")
        user_pass=request.POST.get("password")
        form = login(request.POST)

        # Have we been provided with a valid form?
        if User.objects.filter(userName=user_name , password=user_pass).exists():
            # Now call the index() view.
            # The user will be shown the homepage.
            return validLogin(request)
        else:
            # The supplied form contained errors - just print them to the terminal.
            mesage="Datos incorrectos"
            print form.errors
    else:
        mesage=""
        form = login()

    # Bad form (or form details), no form supplied...
    # Render the form with error messages (if any).
    return render(request, 'server/login.html', {'form': form, 'mesage': mesage})