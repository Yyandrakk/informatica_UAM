from django import forms

class LoginForm(forms.Form):
    username = forms.CharField(max_length=128, label="Username")
    password = forms.CharField(widget=forms.PasswordInput(), label="Password")
    amicat   = forms.BooleanField(label=("amicat"),initial=True, required=False)
    # An inline class to provide additional information on the form.
    class Meta:
        # Provide an association between the ModelForm and a model
        fields = ('username','password','amicat')

class RegisterForm(forms.Form):
    username = forms.CharField(max_length=128, label="Username")
    password = forms.CharField(widget=forms.PasswordInput(), label="Password")

    # An inline class to provide additional information on the form.
    class Meta:
        # Provide an association between the ModelForm and a model
        fields = ('username','password')