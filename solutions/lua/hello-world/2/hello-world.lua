local hello_world = {}

function hello_world.hello()
    local greetings = {
        "Hello, World!",
        "Hey there, World!",
        "Greetings, World!",
        "Howdy, World!",
        "Salutations, World!"
    }
    return greetings[math.random(#greetings)]
end

return hello_world
