--- STEAMODDED HEADER
--- MOD_NAME: Modded Seal
--- MOD_ID: seel-mod
--- MOD_AUTHOR: [stupxd]
--- PREFIX: seel
--- MOD_DESCRIPTION: Modded seal example
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1314c]

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Seal {
    name = "modded-Seal",
    key = "blu",
    badge_colour = HEX("1d4fd7"),
	config = { mult = 5, chips = 20, money = 1, x_mult = 1.5  },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Blu Seal',
        -- Tooltip description
        name = 'Blu Seal',
        text = {
            '{C:mult}+#1#{} Mult',
            '{C:chips}+#2#{} Chips',
            '{C:money}$#3#{}',
            '{X:mult,C:white}X#4#{} Mult',
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.money, self.config.x_mult, } }
    end,
    atlas = "seal_atlas",
    pos = {x=0, y=0},

    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = self.config.mult,
                chips = self.config.chips,
                dollars = self.config.money,
                x_mult = self.config.x_mult
            }
        end
    end,
}

SMODS.Atlas {
    key = "seal_atlas",
    path = "modded_seal.png",
    px = 71,
    py = 95
}

-- Create consumable that will add this seal.

SMODS.Consumable {
    set = "Spectral",
    key = "honk",
	config = {
        -- How many cards can be selected.
        max_highlighted = 1,
        -- the key of the seal to change to
        extra = 'seel_blu',
    },
    loc_vars = function(self, info_queue, card)
        -- Handle creating a tooltip with seal args.
        info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
        -- Description vars
        return {vars = {(card.ability or self.config).max_highlighted}}
    end,
    loc_txt = {
        name = 'Honk',
        text = {
            "Select {C:attention}#1#{} card to",
            "apply {C:attention}Blu Seal{}"
        }
    },
    cost = 4,
    atlas = "honk_atlas",
    pos = {x=0, y=0},
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

SMODS.Atlas {
    key = "honk_atlas",
    path = "honk.png",
    px = 71,
    py = 95
}

----------------------------------------------
------------MOD CODE END----------------------
