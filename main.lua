-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Wendi Yu
-- Created on: Apr 2018
--
-- character move use the button and fix gravity
-----------------------------------------------------------------------------------------

-- Gravity
local physics = require("physics")

physics.start()
physics.setGravity(0, 20)
--physics.setDrawMode("hybrid")

local leftWall = display.newRect( 0, display.contentHeight / 2, 1, display.contentHeight )
-- myRectangle.strokeWidth = 3
-- myRectangle:setFillColor( 0.5 )
-- myRectangle:setStrokeColor( 1, 0, 0 )
leftWall.alpha = 1.0
physics.addBody( leftWall, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local theGround = display.newImageRect( "./assets/sprites/land.png", 1750, 150 )
theGround.x = display.contentCenterX - 190
theGround.y = display.contentCenterY + 690
theGround.id = "the ground"
physics.addBody(theGround, "static", {
	friction = 0.5,
	bounce = 0.3
	})

local theLand = display.newImageRect( "./assets/sprites/land.png", 600, 150 )
theLand.x = display.contentCenterX - 500
theLand.y = display.contentCenterY 
theLand.id = "the land"
physics.addBody(theLand, "static", {
	friction = 0.3,
	bounce = 0.2
	})

local LandSquare = display.newImageRect( "./assets/sprites/land.png", 150, 150 )
LandSquare.x = display.contentCenterX + 200
LandSquare.y = display.contentCenterY 
LandSquare.id = "the land square"
physics.addBody(LandSquare, "dynamic", {
	friction = 0.3,
	bounce = 0.2
	})
LandSquare.isFixedRotation = true

-- Character move
local SnowMen = display.newImageRect( "./assets/sprites/SnowMan.png", 250, 250 )
SnowMen.x = display.contentCenterX - 500
SnowMen.y = display.contentCenterY
SnowMen.id = "the character"
physics.addBody(SnowMen, "dynamic", {
	density = 2.5,
	friction = 0.1,
	bounce = 0.2
	})
SnowMen.isFixedRotation = true -- If you apply this property before the physics.addBody() command for the object, it will merely be treated as a property of the object like any other custom property and, in that case, it will not cause any physical change in terms of locking rotation.

local dPad = display.newImageRect( "./assets/sprites/d-pad.png", 300, 300 )
dPad.x = 150
dPad.y = display.contentHeight - 160
dPad.id = "d-pad"
dPad.alpha = 0.5

local upArrow = display.newImage( "./assets/sprites/upArrow.png" )
upArrow.x = 150
upArrow.y = display.contentHeight - 270
upArrow.id = "up arrow"
upArrow.alpha = 1

local downArrow = display.newImage( "./assets/sprites/downArrow.png" )
downArrow.x = 150
downArrow.y = display.contentHeight - 50
downArrow.id = "down arrow"
downArrow.alpha = 1

local leftArrow = display.newImage( "./assets/sprites/leftArrow.png" )
leftArrow.x = 40
leftArrow.y = display.contentHeight - 160
leftArrow.id = "left arrow"
leftArrow.alpha = 1

local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 160
rightArrow.id = "right arrow"
rightArrow.alpha = 1

local jumpButton = display.newImage( "./assets/sprites/jumpButton.png" )
jumpButton.x = display.contentWidth -80
jumpButton.y = display.contentHeight - 80
jumpButton.id = "jump button"
jumpButton.alpha = 0.5

local function snowmenCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

function upArrow:touch( event )

    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( SnowMen, { 
        	x = 0, -- move 0 in the x direction 
        	y = -50, -- move up 50 pixels
        	time = 1000 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function downArrow:touch( event )
	-- body
	if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( SnowMen, { 
        	x = 0, -- move 0 in the x direction 
        	y = 50, -- move up 50 pixels
        	time = 1000 -- move in a 1/10 of a second
        	} )
    end 
    
    return true    
end

function leftArrow:touch( event )
	-- body
	if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( SnowMen, { 
        	x = -50, -- move 0 in the x direction 
        	y = 0, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end 
    
    return true    
end

function rightArrow:touch( event )
	-- body
	if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( SnowMen, { 
        	x = 100, -- move 0 in the x direction 
        	y = 0, -- move up 50 pixels
        	time = 1000 -- move in a 1/10 of a second
        	} )
    end 
    
    return true    
end

function jumpButton:touch( event )
	-- body
	if ( event.phase == "ended" ) then
        -- move the character jump
       SnowMen:setLinearVelocity( 0, -750 )
    end 
    
    return true    
end

function checkCharacterPosition( event )
	-- check every frame to see if character has fallen
	if SnowMen.y > display.contentHeight + 400 then
		SnowMen.x = display.contentCenterX + 190
        SnowMen.y = display.contentCenterY
    end

end

function checkLandSquarePosition( event )
    -- check every frame to see if character has fallen
    if LandSquare.y > display.contentHeight + 400 then
       LandSquare.x = display.contentCenterX + 200
       LandSquare.y = display.contentCenterY 
    end

end

upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
leftArrow:addEventListener( "touch", leftArrow )
rightArrow:addEventListener( "touch", rightArrow )
jumpButton:addEventListener( "touch", jumpButton )
Runtime:addEventListener("enterFrame", checkCharacterPosition )
Runtime:addEventListener("enterFrame", checkLandSquarePosition )
SnowMen.collision = snowmenCollision
SnowMen:addEventListener( "collision" )