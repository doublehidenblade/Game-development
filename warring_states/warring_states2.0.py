#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pygame, sys
import os
import numpy as np
import itertools
import random
_image_library = {}
clock = pygame.time.Clock()
def get_image(path):
        global _image_library
        image = _image_library.get(path)
        if image == None:
                canonicalized_path = path.replace('/', os.sep).replace('\\', os.sep)
                image = pygame.image.load(canonicalized_path)
                _image_library[path] = image
        return image
def init_political(player_num, map_size):
    political_map = np.random.randint(0,player_num,(map_size,map_size))
    return political_map
def init_army(map_size):
    army_map = np.random.randint(1,7,(map_size,map_size))
    return army_map
def draw_board(screen, political_map, army_map):
    for y,x in itertools.product(range(political_map.shape[0]), range(political_map.shape[1])):
        w = 150-10
        h = 150-10
        tile_color = color[political_map[y][x]]



        pygame.draw.rect(screen, tile_color, pygame.Rect(10+x*150, 10+y*150, w, h))
        army_size = army_map[y][x]
        screen.blit(get_image('images/samurai.png'), (x*150+50, y*150+30))
        # army number text
        font = pygame.font.SysFont("comicsansms", 30)
        text = str(army_map[y][x])
        text = font.render(text, True, tile_color)
        screen.blit(text,(x*150+67, y*150+50))
def verify_move(attacker, defender, player, phase):
    ay = int(attacker[0])
    ax = int(attacker[1])
    dy = int(defender[0])
    dx = int(defender[1])
    if (ax > map_size) or (ay > map_size) or (dx > map_size) or (dy > map_size):
        print("chosen location invalid")
        return 0
    if (political_map[ay][ax] != player) and (phase == "attack"):
        print(ay,ax)
        print(political_map[ay][ax])
        print("Start location does not belong to you")
        return 0
    if (political_map[dy][dx] == player) and (phase == "defend"):
        print(dy,dx)
        print(political_map[dy][dx])
        print("You cannot move towards own region")
        return 0
    if ((abs(dy-ay)>1) or (abs(ax-dx)>1)) and (phase == "defend"):
        print("Please only attack a hostile adjacent region")
        return 0
    else:
        return 1
def battle(political_map, army_map, attacker, defender, current):
    ay = int(attacker[0])
    ax = int(attacker[1])
    dy = int(defender[0])
    dx = int(defender[1])
    if (ax != dx) & (ay !=dy):
        print("Invalid move. You can only attack adjacent regions")
        return (political_map, army_map, 0)
    attack_army = army_map[ay][ax]
    defend_army = army_map[dy][dx]
    attack_power = 0
    defend_power = 0
    for i in range(attack_army):
        attack_power = attack_power + random.randint(1, 6)
    for i in range(defend_army):
        defend_power = defend_power + random.randint(1, 6)
    text = 'Player '+ str(current)
    print(text , " attacked ", defend_army, "defending armies with ", attack_army, "armies")
    print(text , "'s attack power is ", attack_power, "and the enemy defend power is", defend_power)
    if attack_power > defend_power:
        print(text , " overpowered the defender and successfully captured region ", dy, dx)
        political_map[dy][dx] = current
        army_map[dy][dx] = attack_army - 1
        army_map[ay][ax] = 1
    else:
        print(text, " failed to capture location ", dy, dx, "and lost half the troops")
        army_map[ay][ax] = int(attack_army/2)
    print(army_map)
    return (political_map, army_map, 1)

x = 80
y = 80
width = 1200
height = 800
color = ((200, 50, 50), (50, 200, 50), (50, 50, 200), (50,200,200))#red, green, blue, cyan
pygame.init()
screen = pygame.display.set_mode((width, height))
done = False
player_num = 4
map_size = 5
political_map = init_political(player_num, map_size)
print(political_map)

army_map = init_army(map_size)
phase = "attack"
player = 0
#initialize text
font = pygame.font.SysFont("comicsansms", 30)
text = "Game begins!"
master_text = font.render(text, True, (255,255,255))
attacker_selected = False
defender_selected = False

while not done:
        selected = False
        for event in pygame.event.get():
                if event.type == pygame.QUIT:
                        done = True
                if event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE:
                        done = True

        pressed = pygame.key.get_pressed()
        if pressed[pygame.K_w]: y -= 150
        if pressed[pygame.K_s]: y += 150
        if pressed[pygame.K_a]: x -= 150
        if pressed[pygame.K_d]: x += 150
        if pressed[pygame.K_p]:
            player += 1
            player = player % player_num
            print("Player\n", str(player))
        screen.fill((0, 0, 0))

        # update screen after this line

        font = pygame.font.SysFont("comicsansms", 20)
        text = "Player "+ str(player) + "'s turn.'"
        prompt = font.render(text, True, color[player])
        screen.blit(prompt,(10, 750))

        draw_board(screen, political_map, army_map)
        screen.blit(get_image('images/cursor.png'), (x, y))
        if pressed[pygame.K_SPACE]:#selected
            print(phase)
            select_x = x//150
            select_y = y//150
            selected = True
        if (phase == "attack") and (selected):
            attacker = [select_y, select_x]
            if verify_move(attacker, [0,0], player, phase)==1:

                phase = "defend"
                attacker_selected = True
                # print
                font = pygame.font.SysFont("comicsansms", 20)
                text = "Attacker selected"
                master_text = font.render(text, True, (255,255,255))
            else:
                # print
                font = pygame.font.SysFont("comicsansms", 20)
                text = "Please select your army again."
                master_text = font.render(text, True, (255,255,255))

        elif (phase == "defend")  and (selected):
            defender = [select_y, select_x]
            if verify_move(attacker, defender, player, phase)==1:
                # print
                font = pygame.font.SysFont("comicsansms", 20)
                text = "Defender selected."
                master_text = font.render(text, True, (255,255,255))
                defender_selected = True
            else:
                # print
                font = pygame.font.SysFont("comicsansms", 20)
                text = "Please select enemy army again."
                master_text = font.render(text, True, (255,255,255))

        screen.blit(master_text,(200, 750))
        if (attacker_selected == True) and (defender_selected == True):
            (political_map, army_map, result) = battle(political_map, army_map, attacker, defender, player)
            if result == 1:
                attacker_selected = False
                defender_selected = False
                phase = "attack"
            else:
                # print
                font = pygame.font.SysFont("comicsansms", 20)
                text = "Please select enemy army again."
                master_text = font.render(text, True, (255,255,255))
                defender_selected = False
        clock.tick(120)
        pygame.display.flip()
pygame.quit()
quit()


# In[ ]:
