# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import server.models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Game',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('cat1', models.IntegerField(default=57)),
                ('cat2', models.IntegerField(default=59)),
                ('cat3', models.IntegerField(default=61)),
                ('cat4', models.IntegerField(default=63)),
                ('mouse', models.IntegerField(default=4)),
                ('catTurn', models.IntegerField(default=1)),
            ],
        ),
        migrations.CreateModel(
            name='Move',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('origin', server.models.IntegerRangeField()),
                ('target', server.models.IntegerRangeField()),
                ('game', models.ForeignKey(to='server.Game')),
            ],
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('userName', models.CharField(unique=True, max_length=20)),
                ('password', models.CharField(max_length=20)),
            ],
        ),
        migrations.AddField(
            model_name='game',
            name='catUser',
            field=models.ForeignKey(related_name='gamecatUsers', to='server.User'),
        ),
        migrations.AddField(
            model_name='game',
            name='mouseUser',
            field=models.ForeignKey(related_name='gamemouseUsers', to='server.User', null=True),
        ),
    ]
