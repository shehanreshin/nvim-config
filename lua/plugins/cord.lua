return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    opts = {
      buttons = nil,
      hooks = {
        post_activity = function(_, activity)
          activity.buttons = nil
          activity.details_url = nil
          activity.state_url = nil

          if activity.assets then
            activity.assets.large_url = nil
            activity.assets.small_url = nil
          end
        end,
      },
    },
  },
}
