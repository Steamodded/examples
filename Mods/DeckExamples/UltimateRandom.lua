-- Ultimate Random Deck!
-- By: Steamo

local function randomSelect(table)
    for i = 1, 5 do
        math.random()
    end
    if #table == 0 then
        return nil -- Table is empty
    end
    local randomIndex = math.random(1, #table)
    return table[randomIndex]
end

SMODS.Back {
    key = "ultimate",
    pos = { x = 4, y = 3 },
    loc_txt = {
        name = "Ultimate Random",
        text = {
            "Start with a Deck",
            "full of",
            "{C:attention}Random{} cards"
        }
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                local trandom_m = {
                    "m_stone",
                    "m_steel",
                    "m_glass",
                    "m_gold",
                    "m_bonus",
                    "m_mult",
                    "m_wild",
                    "m_lucky",
                    "NOTHING"
                }
                local trandom_e = {
                    "e_foil",
                    "e_holo",
                    "e_polychrome",
                    "NOTHING"
                }
                local trandom_r = {
                    "A",
                    "K",
                    "Q",
                    "J",
                    "T",
                    "9",
                    "8",
                    "7",
                    "6",
                    "5",
                    "4",
                    "3",
                    "2"
                }
                local trandom_s = {
                    "C",
                    "D",
                    "H",
                    "S"
                }
                local trandom_g = {
                    "Red",
                    "Blue",
                    "Gold",
                    "Purple",
                    "NOTHING"
                }
                for i = #G.playing_cards, 1, -1 do
                    local random_m = randomSelect(trandom_m)
                    local random_e = randomSelect(trandom_e)
                    local random_r = randomSelect(trandom_r)
                    local random_s = randomSelect(trandom_s)
                    local random_g = randomSelect(trandom_g)

                    G.playing_cards[i]:set_base(G.P_CARDS[random_s .. "_" .. random_r])
                    if random_m ~= "NOTHING" then
                        G.playing_cards[i]:set_ability(random_m)
                    end
                    if random_e ~= "NOTHING" then
                        G.playing_cards[i]:set_edition(random_e, true, true)
                    end
                    if random_g ~= "NOTHING" then
                        G.playing_cards[i]:set_seal(random_g, true, true)
                    end
                end

                return true
            end
        }))
    end
}

----------------------------------------------
------------MOD CODE END----------------------
