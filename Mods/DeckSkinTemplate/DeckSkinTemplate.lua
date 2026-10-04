local atlas_hc = SMODS.Atlas {
	key = "skin_hc",
	path = "skin_hc.png",
	px = 71,
	py = 95,
}

local atlas_lc = SMODS.Atlas {
	key = "skin_lc",
	path = "skin_lc.png",
	px = 71,
	py = 95,
}

local icon_lc = SMODS.Atlas {
	key = "icon_lc",
	path = "icon_lc.png",
	px = 18,
	py = 18,
}

local icon_hc = SMODS.Atlas {
	key = "icon_hc",
	path = "icon_hc.png",
	px = 18,
	py = 18,
}

SMODS.DeckSkin {
	key = "example",
	suit = "Hearts",
	loc_txt = "Example",
	palettes = {
		{
			key = 'lc',
			ranks = { '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace", },
			display_ranks = { "King", "Queen", "Jack" },
			atlas = atlas_lc.key,
			pos_style = 'suit',
			suit_icon = {
				atlas = icon_lc.key,
			},
		},
		{
			key = 'hc',
			ranks = { '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace", },
			display_ranks = { "King", "Queen", "Jack" },
			atlas = atlas_hc.key,
			pos_style = 'suit',
			colour = HEX("9734f0"),
			suit_icon = {
				atlas = icon_hc.key,
			},
		},
	},
	has_ds_card_ui = function(card, deckskin, palette)
		return true
	end,
	generate_ds_card_ui = function(card, deckskin, palette, info_queue, desc_nodes, specific_vars, full_UI_table)
		-- This uses the localization provided by SMODS.
		-- See artist and artist_credit at https://github.com/Steamodded/smods/blob/main/localization/en-us.lua
		-- You can copy this for your mod and replace the artist or make your own tooltip.
		localize { type = 'other', key = 'artist', nodes = desc_nodes, vars = {} }
		localize { type = 'other', key = 'artist_credit', nodes = desc_nodes,
			vars = { "WilsontheWolf" }, -- artist name goes here
		}
	end
}
