#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pygame
import sys
import os
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
        
class figureSprite(pygame.sprite.Sprite):
    def __init__(self):
        super(figureSprite, self).__init__()
        self.images = []
        self.images.append(get_image('stickman/walk1.png'))
        self.images.append(get_image('stickman/walk2.png'))
        self.images.append(get_image('stickman/walk3.png'))
        self.images.append(get_image('stickman/walk2.png'))
        self.images.append(get_image('stickman/walk1.png'))
        # images are 64x64 pixels

        self.index = 0
        self.image = self.images[self.index]
        self.rect = pygame.Rect(80, 200, 64, 64)

    def update(self):
        '''This method iterates through the elements inside self.images and 
        displays the next one each tick. For a slower animation, you may want to 
        consider using a timer of some sort so it updates slower.'''
        self.index += 1
        if self.index >= len(self.images):
            self.index = 0
        self.image = self.images[self.index]
    def throw(self):
        self.image = get_image('stickman/throw.png')
    def setPosition(self, x,y):
        self.rect.x = x
        self.rect.y = y

class blade1Sprite(pygame.sprite.Sprite):
    def __init__(self):
        super(blade1Sprite, self).__init__()
        self.images = []
        self.images.append(get_image('stickman/bladeup.png'))
        self.images.append(get_image('stickman/bladeright.png'))
        self.images.append(get_image('stickman/bladedown.png'))
        self.images.append(get_image('stickman/bladeleft.png'))
        # images are 64x64 pixels

        self.index = 0
        self.image = self.images[self.index]
        self.rect = pygame.Rect(80, 200, 64, 64)

    def update(self):
        '''This method iterates through the elements inside self.images and 
        displays the next one each tick. For a slower animation, you may want to 
        consider using a timer of some sort so it updates slower.'''
        self.index += 1
        if self.index >= len(self.images):
            self.index = 0
        self.image = self.images[self.index]
    def setPosition(self, x,y):
        self.rect.x = x
        self.rect.y = y


def main():
    pygame.init()
    screen = pygame.display.set_mode((500, 250))
    x1 = 80
    y1 = 200
    vy1 = 0
    vx1 = 0
    bx1 = 80
    by1 = 200
    ba1 = 0
    figure1 = figureSprite()
    group1 = pygame.sprite.Group(figure1)
    blade1out = False
    while True:
        
        event = pygame.event.poll()
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit(0)
        if event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE:
            pygame.quit()
            sys.exit(0)
        
        # update bckgnd
        
        screen.blit(get_image('stickman/stage2.png'), (0, 0))
        screen.fill((170, 70, 70), pygame.Rect(0,0,500,250), 1) # lighten overlay
        
        # update motion
        if x1 <= 0:
            x1 = 0
        elif x1 >= 200:
            x1 = 200
        if y1 < 200:
            in_air = True
            y1 -= vy1
            vy1 -= 1
            figure1.setPosition(x1, y1)
        else:
            y1 = 200 # in case figure falls thru ground
            in_air = False
            vx1 = 0
        if in_air:
            x1 += vx1 * 2
            figure1.setPosition(x1, y1)
        if by1 > 200:
            blade1out = False
            blade1.kill()
        if blade1out:
            by1 -= bvy1
            bvy1 -= 1
            bx1 += bvx1
            blade1.setPosition(bx1, by1)
            blades1.update()
            
        mousePressed = pygame.mouse.get_pressed()
        pressed = pygame.key.get_pressed()   
        if pressed[pygame.K_d] and (in_air == False): # key held down
            vx1 = 4
            x1 += vx1
            figure1.setPosition(x1, y1)
            group1.update()
        if pressed[pygame.K_a] and (in_air == False): # key held down
            vx1 = -4
            x1 += vx1
            figure1.setPosition(x1, y1)
            group1.update()
        if (event.type == pygame.KEYDOWN) and (event.key == pygame.K_w) and (in_air == False): # key pressed
            vy1 = 7
            y1 -= vy1
            figure1.setPosition(x1, y1)
            vy1 -= 1
            #print(y1,a1)
        if (event.type == pygame.KEYDOWN) and (event.key == pygame.K_SPACE) and (blade1out == False): # key pressed, blade thrown
            figure1.throw()
            blade1 = blade1Sprite()
            blades1 = pygame.sprite.Group(blade1)
            bvy1 = 7
            bvx1 = 15
            bx1 = x1 + bvx1 + vx1
            by1 = y1
            by1 -= bvy1
            blade1.setPosition(bx1, by1)
            bvy1 -= 1
            blade1out = True
            blades1.update()
        
        group1.draw(screen)
        if blade1out:
            blades1.draw(screen)
        pygame.display.flip()
        
    pygame.quit()
exit()
if __name__ == '__main__':
    main()


# 
