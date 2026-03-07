function love.conf(t)
    t.title = "数风流 (Shu Fengliu)"
    t.version = "11.4"
    t.window.width = 1920
    t.window.height = 1080
    t.window.resizable = true
    t.window.fullscreen = false
    t.window.vsync = true
    
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = false
    t.modules.sound = true
    t.modules.system = true
    t.modules.thread = false
    t.modules.timer = true
    t.modules.touch = false
    t.modules.video = false
    t.modules.window = true
end
