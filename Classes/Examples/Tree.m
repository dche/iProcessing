/**
 * Recursive Tree
 * by Daniel Shiffman.  
 * 
 * Renders a simple tree-like structure via recursion. 
 * The branching angle is calculated as a function of 
 * the horizontal mouse location. Move the mouse left
 * and right to change the angle.
 */
/*
float theta;   

void setup() {
    size(640, 360);
    smooth();
}

void draw() {
    background(0);
    frameRate(30);
    stroke(255);
    // Let's pick an angle 0 to 90 degrees based on the mouse position
    float a = (mouseX / (float) width) * 90f;
    // Convert it to radians
    theta = radians(a);
    // Start the tree from the bottom of the screen
    translate(width/2,height);
    // Draw a line 120 pixels
    line(0,0,0,-120);
    // Move to the end of that line
    translate(0,-120);
    // Start the recursive branching!
    branch(120);
    
}

void branch(float h) {
    // Each branch will be 2/3rds the size of the previous one
    h *= 0.66;
    
    // All recursive functions must have an exit condition!!!!
    // Here, ours is when the length of the branch is 2 pixels or less
    if (h > 2) {
        pushMatrix();    // Save the current state of transformation (i.e. where are we now)
        rotate(theta);   // Rotate by theta
        line(0, 0, 0, -h);  // Draw the branch
        translate(0, -h); // Move to the end of the branch
        branch(h);       // Ok, now call myself to draw two new branches!!
        popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
        
        // Repeat the same thing, only branch off to the "left" this time!
        pushMatrix();
        rotate(-theta);
        line(0, 0, 0, -h);
        translate(0, -h);
        branch(h);
        popMatrix();
    }
}
*/
//
//  Tree.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-02.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Tree.h"

@interface Tree ()

- (void)branch:(float)h;

@end


@implementation Tree

- (void)setup
{
    [self size:320 :320];
    [self smooth];
}

- (void)draw
{
    [self background:[self color:0]];
    [self frameRate:30];
    [self stroke:[self color:255]];
    // Let's pick an angle 0 to 90 degrees based on the mouse position
    float a = ([self mouseX] / self.width) * 90.0f;
    // Convert it to radians
    theta = [self radians:a];
    // Start the tree from the bottom of the screen
    [self translate:self.width/2 :self.height];
    // Draw a line 120 pixels
    [self line:0:0:0:-90];
    // Move to the end of that line
    [self translate:0:-90];
    // Start the recursive branching!
    [self branch:90];
}

- (void)branch:(float)h
{
    // Each branch will be 2/3rds the size of the previous one
    h *= 0.66;
    
    // All recursive functions must have an exit condition!!!!
    // Here, ours is when the length of the branch is 2 pixels or less
    if (h > 2) {
        [self pushMatrix];    // Save the current state of transformation (i.e. where are we now)
        [self rotate:theta];   // Rotate by theta
        [self line:0 :0 :0 :-h];  // Draw the branch
        [self translate:0 :-h]; // Move to the end of the branch
        [self branch:h];       // Ok, now call myself to draw two new branches!!
        [self popMatrix];     // Whenever we get back here, we "pop" in order to restore the previous matrix state
        
        // Repeat the same thing, only branch off to the "left" this time!
        [self pushMatrix];
        [self rotate:-theta];
        [self line:0 :0 :0 :-h];
        [self translate:0 :-h];
        [self branch:h];
        [self popMatrix];
    }
}

@end
