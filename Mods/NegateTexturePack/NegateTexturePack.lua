-- Consider using Malverk instead for better texture pack support
-- https://github.com/Eremel/Malverk

sendDebugMessage("Launching Negate Texture Pack!", "NegateTexturePack")

SMODS.Atlas{key = "Joker", path = "Jokers-negate.png", px = 71, py = 95, prefix_config = { key = false } }
SMODS.Atlas{key = "Booster", path = "boosters-negate.png", px = 71, py = 95, prefix_config = { key = false } }
SMODS.Atlas{key = "blind_chips", path = "BlindChips-negate.png", px = 34, py = 34, prefix_config = { key = false }, atlas_table = 'ANIMATION_ATLAS', frames = 21}
