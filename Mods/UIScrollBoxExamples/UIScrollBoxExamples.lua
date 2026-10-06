local examples = {}

-- Basic example
examples[1] = function()
	-- Object we want render cropped. In this and future examples it will be Jimbo card
	local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.j_joker, {})

	-- Creating scroll box
	local box = SMODS.UIScrollBox({
		-- Specifying content for rendering
		content = card,

		-- Adjusting overflow container properties
		overflow = {
			node_config = {
				-- set container sizes
				-- any content which does not fit will be cropped
				h = 1,
				w = 1.5,
			},
		},
	})

	-- UIScrollBox extends UIBox, put it into G.UIT.O as usual
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.O,
				config = { object = box },
			},
		},
	}
end

-- Examples of valid inputs for content
examples[2] = function()
	if false then
		-- as content UIScrollBox supports all things supported by G.UIT.O such as:

		-- CardArea or a card
		local area = CardArea(0, 0, 1, 3, { type = "title" })
		local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.j_joker, {})
		area:emplace(card)

		SMODS.UIScrollBox({
			content = card,
		})
		-- or
		SMODS.UIScrollBox({
			content = area,
		})

		-- DynaText
		local dyna = DynaText({
			string = { "Scrolling things" },
			scale = 0.5,
			colours = { G.C.WHITE },
		})

		SMODS.UIScrollBox({
			content = dyna,
		})

		-- Sprite
		local sprite = Sprite(0, 0, 2, 2, G.ASSET_ATLAS["tags"], { x = 0, y = 0 })
		SMODS.UIScrollBox({
			content = sprite,
		})

		-- another UIBox
		local uibox = UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.MULT, h = 3, w = 4 },
			},
			config = {},
		})

		SMODS.UIScrollBox({
			content = uibox,
		})

		-- additionally, as a shortcut, definition for UIBox can be passed too
		local uibox_init = {
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.CHIPS, h = 6, w = 7 },
			},
			config = {},
		}

		SMODS.UIScrollBox({
			content = uibox_init,
		})
	end
	return {

	}
end

-- Shortcut for debug tools
local function as_o(content)
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.O,
				config = { object = content },
			},
		},
	}
end

-- Example for specifying overflow directions and maxw/maxh
examples[3] = function()
	local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.j_joker, {})

	local box = SMODS.UIScrollBox({
		content = card,
		overflow = {
			node_config = {
				-- set max height of container
				maxh = 1,

				-- set cropping to be applied only vertically, leaving horizontal part as-is
				no_overflow = "v",
			},
		},
	})

	return as_o(box)
end

-- Progress explanation
examples[4] = function()
	local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.j_joker, {})

	local box = SMODS.UIScrollBox({
		content = card,
		overflow = {
			node_config = {
				maxh = 1,
				maxw = 1,
			},
		},

		-- by default, top left part of content will be visible
		--
		-- progress determines how move content inside container and similar to how scroll works in browser:
		-- value `0` = content's top/left matches container's top/left
		-- value `1` = content's bottom/right matches container's bottom/right
		-- (values out of bounds works too)
		progress = { x = 1, y = 1 },
	})

	return as_o(box)
end

-- Offset & sync mode explanation
examples[5] = function()
	local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.j_joker, {})

	local box = SMODS.UIScrollBox({
		content = card,
		overflow = {
			node_config = {
				maxh = 1,
				maxw = 1,
			},
		},
		-- similar to progress, offset decides which part of content will be visible
		-- instead of percent, it uses in-game units
		-- positive values move content in bottom/right direction, negative in top/left
		offset = { x = -0.5, y = 0.5 },

		-- by default, every frame offset is calculated from progress
		-- which means all direct changes to offset will be overrided
		--
		-- sync_mode specified which of properties is dominant
		-- `progress` - offset calculated from progress
		-- `offset` - progress calculated from offset
		sync_mode = "offset",
	})

	return as_o(box)
end

-- Scroll move example (based on progress)
examples[6] = function()
	local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.j_joker, {})

	local box = SMODS.UIScrollBox({
		content = card,
		overflow = {
			node_config = {
				maxw = 1,
			},
		},
		-- Function which called every frame
		-- and can be used to update scroll position
		--
		-- In this example, card will scroll from left to right in 1 second
		-- then from right to left in 1 second, and repeat
		scroll_move = function(self, dt)
			-- update x progress every frame
			self.scroll_progress.x = self.scroll_progress.x + dt * (self.back_dir and -1 or 1)

			-- Go back after we reach right side
			if self.scroll_progress.x > 1 then
				self.back_dir = true
				self.scroll_progress.x = math.max(0, 2 - self.scroll_progress.x)
			end
			-- Go forward and repeat a loop
			if self.scroll_progress.x < 0 then
				self.back_dir = false
				self.scroll_progress.x = math.min(1, -self.scroll_progress.x)
			end
		end,
	})

	return as_o(box)
end

-- Scroll move example (based on offset) + using values as ref_table[ref_value]
examples[7] = function()
	local dyna = DynaText({
		string = "Pretty long text which will move too fast if we use progress",
		scale = 0.32,
		colours = { G.C.WHITE },
	})

	local box = SMODS.UIScrollBox({
		content = dyna,
		overflow = {
			node_config = {
				maxw = 1,
			},
		},

		sync_mode = "offset",

		-- Similar to previous example, but instead of progress, offset is used
		--
		-- Scroll moves 1 unit per second
		scroll_move = function(self, dt)
			-- This function returns scrollable distance in game units
			local max_x, max_y = self:get_scroll_distance()
			self.scroll_offset.x = self.scroll_offset.x + dt * (self.back_dir and -1 or 1)

			if self.scroll_offset.x > max_x then
				self.back_dir = true
				self.scroll_offset.x = math.max(0, 2 * max_x - self.scroll_offset.x)
			end
			if self.scroll_offset.x < 0 then
				self.back_dir = false
				self.scroll_offset.x = math.min(max_x, -self.scroll_offset.x)
			end
		end,
	})

	local values_display = {
		n = G.UIT.R,
		nodes = {
			{
				n = G.UIT.R,
				nodes = {
					{ n = G.UIT.T, config = { text = "Progress: ", scale = 0.32 } },
					-- Display real-time progress
					{
						n = G.UIT.T,
						config = { ref_table = box.scroll_progress, ref_value = "x", decimal_places = 2, scale = 0.32 },
					},
				},
			},
			{
				n = G.UIT.R,
				nodes = {
					{ n = G.UIT.T, config = { text = "Offset: ", scale = 0.32 } },
					-- Display real-time offset
					{
						n = G.UIT.T,
						config = { ref_table = box.scroll_offset, ref_value = "x", decimal_places = 2, scale = 0.32 },
					},
				},
			},
		},
	}

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			values_display,
			{
				n = G.UIT.R,
				nodes = { { n = G.UIT.O, config = { object = box } } },
			},
		},
	}
end

-- Real use-case: mod badge
examples[8] = function()
	-- Text to display
	local badge_text = DynaText({
		string = "Mod Name",
		colours = { G.C.WHITE },
		float = true,
		shadow = true,
		offset_y = -0.05,
		silent = true,
		spacing = 1,
		scale = 0.297,
	})
	local badge_scroll = SMODS.UIScrollBox({
		content = badge_text,
		container = {
			-- Make sure badge is not collideable
			config = {
				can_collide = false,
			},
		},
		overflow = {
			node_config = {
				no_overflow = "h",
				maxw = 1.732,
			},
			-- Make sure badge is not collideable
			config = {
				can_collide = false,
			},
		},
		sync_mode = "offset",

		-- When badge appears, text don't move first 1.5 seconds
		-- Then, it scrolls until fully disappears from the left side
		-- After that reappears from right side
		-- Scroll until start position, and loop repeats
		scroll_move = function(self, dt)
			local dx = self:get_scroll_distance()
			if dx == 0 then
				return
			end
			if not self.scroll_start_pause then
				self.scroll_start_pause = 1.5
			end
			if self.scroll_start_pause > 0 and self.scroll_offset.x >= 0 then
				self.scroll_start_pause = self.scroll_start_pause - G.real_dt
			else
				self.scroll_offset.x = (self.scroll_offset.x or 0) + G.real_dt / 1.5
				if self.scroll_offset.x > self.content_container.T.w then
					self.scroll_start_pause = 1.5
					self.scroll_offset.x = -self.T.w - 0.1
				end
			end
		end,
	})
	return {
		n = G.UIT.R,
		config = {
			align = "cm",
			colour = G.C.GREEN,
			r = 0.1,
			minw = 2,
			minh = 0.36,
			emboss = 0.05,
			padding = 0.027,
		},
		nodes = {
			{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
			{ n = G.UIT.O, config = { id = "smods_mod_badge_text", object = badge_scroll } },
			{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
		},
	}
end

SMODS.current_mod.extra_tabs = function()
	local example_tabs = {}
	for i, example in ipairs(examples) do
		example_tabs[#example_tabs + 1] = {
			label = 'Example ' .. i,
			tab_definition_function = function()
				return {
					n = G.UIT.ROOT,
					nodes = {
						{
							n = G.UIT.R,
							nodes = {
								example()
							},
						}
					}
				}
			end,
		}
	end
	return example_tabs
end
