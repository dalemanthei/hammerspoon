
-- Set up Capslock hyper (mega-meta) key
-- hattip https://github.com/lodestone/hyper-hacks
-- hattip https://gist.github.com/ttscoff/cce98a711b5476166792d5e6f1ac5907
-- hattip https://gist.github.com/prenagha/1c28f71cb4d52b3133a4bff1b3849c3e

-- A global variable for the Hyper Mode
local k = hs.hotkey.modal.new({}, "f17")

local hyperModifiers = {'cmd','alt','shift','ctrl'}
local hyperKey = hs.hotkey.modal.new({}, "f17")

-- The following keys are configured as hot keys in their respective apps (or in Keyboard Maestro)
-- a → Airmail 3 (configure in Airmail 3 preferences)
-- b → Bartender 2 (configure in Bartender 2 preferences)
-- d → Dash (configure in Dash preferences)
-- h → HazeOver (configure in HazeOver preferences)
-- m → Moom (configure in Moom preferences)
-- n → Notifications configure in System preferences → Keyboard → Shortcuts → Mission Control)
-- f → Fantastical (configure in Fantastical preferences)
-- s → Sound output change (configure in Keyboard Maestro)
-- t → Typinator (configure in Typinator preferences)
-- ' → Iterm2 hotkey window (configure in Iterm2 preferences as ⌘⌥^⇧" but single quote here because hyper adds shift)
-- SPACE → Spotlight (configure in System Preferences → Keyboard → Shortcuts → Spotlight, moved so that ⌘␣ could be used for Quicksilver)
hyperBindings = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','\'','SPACE', '-', '='}

for i,key in ipairs(hyperBindings) do
  hyperKey:bind({}, key, nil, function() hs.eventtap.keyStroke(hyperModifiers, key)
    hyperKey.triggered = true
  end)
end

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  hyperKey.triggered = false
  hyperKey:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  hyperKey:exit()
  if not hyperKey.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'f18', pressedF18, releasedF18)

hs.hotkey.bind({'cmd','alt','ctrl'}, 'j', function()
    if hs.spotify.isPlaying() then
      hs.spotify.pause()
    else
      hs.spotify.play()
    end
  end)
hs.hotkey.bind({'cmd','alt','ctrl'}, 'k', function() hs.spotify.volumeDown() end)
hs.hotkey.bind({'cmd','alt','ctrl'}, 'l', function() hs.spotify.volumeUp() end)
-- hs.hotkey.bind({'cmd','alt','ctrl'}, 'J', hs.spotify.displayCurrentTrack)
-- hs.hotkey.bind({'cmd','alt','ctrl'}, 'K',     hs.spotify.pause)
-- hs.hotkey.bind({'cmd','alt','ctrl'}, 'N',     hs.spotify.next)
-- hs.hotkey.bind({'cmd','alt','ctrl'}, 'I',     hs.spotify.previous)


-- AppleScript bindings
hyperKey:bind({}, 'o', nil, function() hs.execute ('osascript /Users/manthei/Dropbox/AppleScripts/OmniFocus/QuickOpen.scpt') hyperKey.triggered = true end)

return hyperKey;