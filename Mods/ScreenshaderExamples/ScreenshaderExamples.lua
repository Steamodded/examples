SMODS.ScreenShader {
    key = "test_screenshader",
    path = "screenshader.fs", -- found in /assets/shaders/screenshader.fs
    -- additionally, you can reference an existing shader by key
    should_apply = function(self)
        --called every frame to determine if the screenshader should be rendered or not
        return true
    end,
    send_vars = function(self)
        -- also called every frame, used to send variables from Balatro to the shader.
        return {
            example_number = 0.5,
            example_vec3 = { 1, 0.7, 0.7 }
        }
    end,
}
