from django.contrib import admin
from models import *

# Register your models here.

class UserAdmin(admin.ModelAdmin):
    ist_display=('userName', 'password')

class GameAdmin(admin.ModelAdmin):
    ist_display=('catUser', 'mouseUser', 'cat1', 'cat2', 'cat3', 'cat4', 'mouse', 'catTurn')

class MoveAdmin(admin.ModelAdmin):
     ist_display=('origin', 'target', 'game')

admin.site.register(User, UserAdmin)
admin.site.register(Game, GameAdmin)
admin.site.register(Move, MoveAdmin)