-- Absolute Deck of PolyGlass!
-- By: Steamo

SMODS.Back {
    key = "absolute",
    pos = { x = 0, y = 3 },
    loc_txt = {
        name = "Absolute Deck",
        text = {
            "Start with a Deck",
            "full of {C:attention,T:e_polychrome}Poly{}{C:red,T:m_glass}glass{} cards"
        },
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_ability("m_glass")
                    G.playing_cards[i]:set_edition("e_polychrome", true, true)
                end
                return true
            end
        }))
    end
}
