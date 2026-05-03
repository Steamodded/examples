-- Create a special deck that only contains 4s!
-- By: Steamo

SMODS.Back {
    name = "Deck of fours",
    key = "fours",
    pos = { x = 1, y = 3 },
    config = { only_one_rank = '4' },
    loc_txt = {
        name = "Deck of fours",
        text = {
            "Start with a Deck",
            "full of {C:attention}Fours{}",
        },
    },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, self.config.only_one_rank))
                end
                return true
            end
        }))
    end
}
