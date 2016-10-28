__author__ = 'e280671'
from django import forms
from models import User

class add_user(forms.ModelForm):
    userName = forms.CharField(max_length=20, help_text="Please enter your name.")
    password = forms.CharField(widget=forms.PasswordInput, max_length=20, help_text="Please enter your password.")


    # An inline class to provide additional information on the form.
    class Meta:
        # Provide an association between the ModelForm and a model
        model = User
        fields = ('userName', 'password', )

    def clean(self):
        cleaned_data = self.cleaned_data
        url = cleaned_data.get('url')

        # If url is not empty and doesn't start with 'http://', prepend 'http://'.
        if url and not url.startswith('http://'):
            url = 'http://' + url
            cleaned_data['url'] = url

        return cleaned_data


class login(forms.Form):
    userName = forms.CharField(max_length=20, help_text="Please enter your name.")
    password = forms.CharField(widget=forms.PasswordInput, max_length=20, help_text="Please enter your password.")

    class Meta:
        # Provide an association between the ModelForm and a model
        model = User

        # What fields do we want to include in our form?
        # This way we don't need every field in the model present.
        # Some fields may allow NULL values, so we may not want to include them...
        # Here, we are hiding the foreign key.
        # we can either exclude the category field from the form,
        fields = ('userName', 'password', )
        #or specify the fields to include (i.e. not include the category field)
        #fields = ('title', 'url', 'views')

    def clean(self):
        cleaned_data = self.cleaned_data
        url = cleaned_data.get('url')

        # If url is not empty and doesn't start with 'http://', prepend 'http://'.
        if url and not url.startswith('http://'):
            url = 'http://' + url
            cleaned_data['url'] = url

        return cleaned_data