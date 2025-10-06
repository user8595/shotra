-- resolution
wWidth, wHeight = love.graphics.getWidth(), love.graphics.getHeight()
gWidth, gHeight = 640, 480
tX, tY = (wWidth - gWidth) / 2, (wHeight - gHeight) / 2

-- fonts
monogram = love.graphics.newFont("assets/monogram.ttf", 24)
monogramL = love.graphics.newFont("assets/monogram.ttf", 32)
picopixel = love.graphics.newFont("assets/Picopixel.ttf", 14)

-- general
isDebug = false
isOptions = false
isAbout = false
isPaused = false
isShake = false
isAutoFire = true

-- gameplay cooldowns
isLoseLife = false
isUseBomb = false
isPauseDelay = false

-- game
isShoot = false
isWarning = false
isBoss = false
--TODO: Add game finish/win states
isWin = false

-- fail screens
isContinue = false
isFail = false

-- combo cooldown time
comboTime = 0
-- screen shake timer
shakeTimer = 0

isTrnsition = false

-- extra life effect
isExtend = false
Etimer = 0

-- player
player = {
    x = gWidth / 2 - 12,
    y = gHeight - 60,
    w = 24,
    h = 24,

    -- hitbox
    vx = 200,
    vy = 200,
    cDown = 0,
    
    -- invincible on start of game
    invis = true,
    iCool = 0,
    bombCool = 0,
    dead = false,
    lostLifeCool = 0
}

hitbox = {
    x = player.x + 8,
    y = player.y + 8,
    w = 5,
    h = 5,
}

-- player bullets
pBlList_1, pBlList_2, pBlList_3 = {}, {}, {}

-- level objects
--TODO: Add bosses?
enemies, boss, items, textEffect = {}, {}, {}, {}

-- enemy objects
eBullet = {}

-- game display
gameWorld = {
    x = gWidth / 4,
    y = 0,
    w = gWidth / 2,
    h = gHeight,
    scroll = 50
}

-- stats
stats = {
    score = 0,
    hScore = 0,
    life = 2,
    exLife = 350000,
    
    combo = 0,
    mCombo = 0,
    enemies = 0,
    continues = 0,
    
    pTier = 1,
    bomb = 2,

    gameTime = 0,
}

scoreCombo = 0
-- item score text effect string
itemScore = "200"

-- current game stage
stage = "TEST_4" -- "TEST", "TEST_2", "TEST_3", "TEST_4"
-- difficulty
diff = "normal" -- "easy", "normal", "hard"

-- game state
state = "game" -- "title", "menu", "select", "game"

-- keybinds
keys = {
    up = "up",
    down = "down",
    left = "left",
    right = "right",
    shoot = "z",
    slow = "x",
    bomb = "c",
    pause = {"p", "escape"}
}

-- colours
bgCol = {0.05, 0.05, 0.05}
screenCol = {0.05, 0.05, 0.05}
borderColour = {0, 0, 0}
popupOverlay = {0, 0, 0, 0.65}
white = {1, 1, 1, 1}
gray = {0.5, 0.5, 0.5, 1}
livesTxt = {0.5, 0.5, 0.5, 1}

gold = {1, 1, 0, 1}
goText = {1, 1, 1, 0}

lifeBarColor = {1, 0.3, 0.3, 0.5}

playerColour = {1, 1, 1, 1}
