love.graphics.setDefaultFilter("nearest", "nearest")

whitePixel = love.graphics.newImage(love.image.newImageData(1, 1, "rgba8", "\255\255\255\255"))

border = {
    love.graphics.newImage("assets/textures/border_side.png"),
    love.graphics.newImage("assets/textures/border_corner.png")
}
