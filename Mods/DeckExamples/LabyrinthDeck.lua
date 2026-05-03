-- Implements an unused deck hidden in the game's textures
-- By: MathIsFun_

SMODS.Back {
    key = "labyrinth",
    pos = { x = 0, y = 4 },
    config = { hands = -3, discards = 5 },
    loc_txt = {
        name = "Labyrinth Deck",
        text = {
            "{C:red}+#1#{} discards",
            "{C:blue}#2#{} hands",
            "every round"
        }
    },
    loc_vars = function(self)
        return { vars = { self.config.discards, self.config.hands } }
    end
}
