-- resolution
wWidth, wHeight = love.graphics.getWidth(), love.graphics.getHeight()
gWidth, gHeight = 640, 480

-- fonts
monogram = love.graphics.newFont("assets/monogram.ttf", 24)
monogramL = love.graphics.newFont("assets/monogram.ttf", 32)
picopixel = love.graphics.newFont("assets/Picopixel.ttf", 14)

-- general
isDebug = false
isOptions = false
isAbout = false
isPaused = false

-- gameplay cooldowns
isLoseLife = false
isUseBomb = false
isPauseDelay = false

-- game
isShoot = false
--TODO: Add auto fire toggle
isAutoFire = false
isBoss = false

-- fail screens
isContinue = false
isFail = false

-- combo cooldown time
comboTime = 0

isTrnsition = false

-- player
player = {
    x = gWidth / 2 - 12,
    y = gHeight - 60,
    w = 24,
    h = 24,

    -- hitbox
    hW = 5,
    hH = 5,

    vx = 200,
    vy = 200,
    cDown = 0,

    dead = false
}

-- left side
pBlList_1, pBlList_2, pBlList_3 = {}, {}, {}

-- game display
gameWorld = {
    x = gWidth / 4,
    y = 0,
    w = gWidth / 2,
    h = gHeight,
    scroll = 200
}

-- stats
stats = {
    score = 0,
    hScore = 0,
    life = 2,
    
    combo = 0,
    mCombo = 0,
    enemies = 0,
    continues = 0,

    pTier = 1,
    bomb = 3,
}

-- current game stage
stage = 1
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
borderColour = {0, 0, 0}
popupOverlay = {0, 0, 0, 0.65}
white = {1, 1, 1, 1}
gray = {0.5, 0.5, 0.5, 1}
gold = {1, 1, 0, 1}
goText = {1, 1, 1, 0}
