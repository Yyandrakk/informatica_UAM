from django.db import models

# Create your models here.

class IntegerRangeField(models.IntegerField):
    def __init__(self, verbose_name=None, name=None, min_value=None, max_value=None, **kwargs):
        self.min_value, self.max_value = min_value, max_value
        models.IntegerField.__init__(self, verbose_name, name, **kwargs)
    def formfield(self, **kwargs):
        defaults = {'min_value': self.min_value, 'max_value':self.max_value}
        defaults.update(kwargs)
        return super(IntegerRangeField, self).formfield(**defaults)


class User(models.Model):
    userName = models.CharField(max_length=20,unique=True)
    password = models.CharField(max_length=20)

    def __unicode__(self):
        return self.userName


class Game(models.Model):
    catUser = models.ForeignKey(User, related_name='gamecatUsers', null=False)
    mouseUser = models.ForeignKey(User, related_name='gamemouseUsers', null=True)
    cat1 = models.IntegerField(default=57, null=False)
    cat2 = models.IntegerField(default=59, null=False)
    cat3 = models.IntegerField(default=61, null=False)
    cat4 = models.IntegerField(default=63, null=False)
    mouse = models.IntegerField(default=4, null=False)
    catTurn = models.IntegerField(default=1, null=False)

    def __unicode__(self):
        if self.mouseUser:
            return self.catUser.userName +" y " + self.mouseUser.userName
        else:
            return self.catUser.userName

class Move(models.Model):
    origin   = IntegerRangeField(null=False, min_value=0, max_value=63)
    target   = IntegerRangeField(null=False, min_value=0, max_value=63)
    game  = models.ForeignKey(Game, null=False)

    def __unicode__(self):
         if self.game.mouseUser:
            return self.game.catUser.userName +" and " + self.game.mouseUser.userName
         else:
            return self.game.catUser.userName
