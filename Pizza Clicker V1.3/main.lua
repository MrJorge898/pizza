function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    music = 1
    pizza = 0
    ppcc = 150
    ppc = 1
    ppsc = 25
    pps = 0
    timer = 1
    
    font = love.graphics.newFont(20)
    font2 = love.graphics.newFont(16)

    background = love.graphics.newImage("images/background.png")
    pizzai = love.graphics.newImage("images/pizza.png")
    basil = love.graphics.newImage("images/basil.png")
    mushrooms = love.graphics.newImage("images/mushrooms.png")
    pizzabi = love.graphics.newImage("images/bpizza.png")
    bacon = love.graphics.newImage("images/bacon.png")

    sounds = {}
    
    sounds.star = love.audio.newSource("sounds/stardust.mp3", "stream")
    sounds.studio = love.audio.newSource("sounds/studio.mp3", "stream")
    sounds.hydro = love.audio.newSource("sounds/hydro.mp3", "stream")
    sounds.battery = love.audio.newSource("sounds/battery.mp3", "stream")
    sounds.blip = love.audio.newSource("sounds/blip.wav", "static")
    sounds.bong = love.audio.newSource("sounds/bong.wav", "static")
    sounds.ding = love.audio.newSource("sounds/ding.wav", "static")
    sounds.star:setLooping(true)
    sounds.studio:setLooping(true)
    sounds.battery:setLooping(true)
    sounds.hydro:setLooping(true)

    sounds.star:play()

    menu = 1
    sound = 1

    ico = love.image.newImageData("images/icon.png")
    ok = love.window.setIcon(ico)
    love.window.setTitle("Pizza Clicker v1.3")
    love.window.setMode(300, 300, {resizable=false, vsync=true, minwidth=400, minheight=300})
end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end

    if timer < 0 then
        timer = 1
        pizza = pizza + pps
    end
    
    if music == 1 then
        sounds.star:play()
        sounds.studio:stop()
        sounds.battery:stop()
        sounds.hydro:stop()
    end

    if music == 2 then
        sounds.star:stop()
        sounds.studio:play()
        sounds.battery:stop()
        sounds.hydro:stop()
    end

    if music == 3 then
        sounds.star:stop()
        sounds.studio:stop()
        sounds.battery:play()
        sounds.hydro:stop()
    end

    if music == 4 then
        sounds.star:stop()
        sounds.studio:stop()
        sounds.battery:stop()
        sounds.hydro:play()
    end

    if music == 0 then
        sounds.star:stop()
        sounds.studio:stop()
        sounds.battery:stop()
        sounds.hydro:stop()
    end

    if music < 0 then
        music = 0
    end

    if music > 4 then
        music = 4
    end
end


function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.setFont(font)

    if menu == 1 then
        love.graphics.draw(pizzai, 100, 100, nil, 0.2, 0.2)

        love.graphics.setColor(0, 0, 1)
        love.graphics.print(pizza, 60, 0)
        love.graphics.print("pizza:", 0, 0)
        love.graphics.print("pps:", 0, 25)
        love.graphics.print(pps, 45, 25)
        love.graphics.print("ppc:", 0, 50)
        love.graphics.print(ppc, 45, 50)
        love.graphics.setFont(font2)
        love.graphics.print("Cost of next pps upgrade: ", 0, 250)
        love.graphics.print("Cost of next ppc upgrade:", 0, 275)
        love.graphics.setFont(font)
        love.graphics.print(ppsc, 210, 250)
        love.graphics.print(ppcc, 215, 275)
        love.graphics.setColor(255, 255, 255)

        if pps == 24 then
            love.graphics.draw(basil, 245, 245, nil, 0.04, 0.03)
        end

        if ppc == 9 then
            love.graphics.draw(mushrooms, 265, 265, nil, 0.06, 0.06)
        end

        if ppc == 24 then
            love.graphics.draw(bacon, 265, 265, nil, 0.06, 0.06)
        end

        if pps >= 25 then
            love.graphics.draw(basil, 90, 100, nil, 0.14, 0.13)
        end

        if ppc >= 10 then
            love.graphics.draw(mushrooms, 100, 100, nil, 0.2, 0.2)
        end

        if ppc >= 25 then
            love.graphics.draw(bacon, 100, 100, nil, 0.2, 0.2)
        end

        if ppc >= 50 then
            if pps >= 100 then
                love.graphics.draw(pizzabi, 100, 90, nil, 0.3, 0.3)
            end
        end

        if pps >= 250 then
            love.graphics.draw(basil, 100, 100, nil, 0.14, 0.13)
        end

        if ppc >= 150 then
            love.graphics.draw(mushrooms, 120, 100, nil, 0.2, 0.2)
        end

        if ppc >= 200 then
            love.graphics.draw(bacon, 120, 100, nil, 0.2, 0.2)
        end
    end

    if menu == 2 then
        music = 0
        love.graphics.setColor(0, 0, 1)
        love.graphics.print("Options", 150, 0)
        love.graphics.print("Sounds:", 0, 50)
        love.graphics.print(sound, 85, 50)
        love.graphics.print("1 = true 2 = false", 0, 250)
        love.graphics.setColor(255, 255, 255)
    end
end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 then
        if sound == 1 then
            sounds.bong:stop()
        end
        pizza = pizza + ppc
        if sound == 1 then
            sounds.bong:play()
        end
    end
end

function love.keypressed( key, scancode, isrepeat )
    if key == "q" then
        if pizza >= ppcc then
            pizza = pizza - ppcc
            ppcc = ppcc + 150
            if sound == 1 then
                sounds.ding:stop()
            end
            ppc = ppc + 1
            if sound == 1 then
                sounds.ding:play()
            end
        end
    end
    if key == "e" then
        if pizza >= ppsc then
            pizza = pizza - ppsc
            ppsc = ppsc + 25
            if sound == 1 then
                sounds.blip:stop()
            end
            pps = pps + 1
            if sound == 1 then
                sounds.blip:play()
            end
        end
    end

    if menu == 1 then
        if key == "right" then
            music = music + 1
        end

        if key == "left" then
            music = music - 1
        end
    end

    if menu == 2 then
        if key == "up" then
            if sound == 1 then
                sound = 2
            else
                sound = 1
            end
        end
    end

    if key == "r" then
        if menu == 1 then
            menu = 2
        else
            menu = 1
        end
    end

    if key == "escape" then
        love.event.quit()
    end
end