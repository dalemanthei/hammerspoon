
-- reload on change, do this first so it works even if error
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

require('capslock')
require('scansnap')
-- require('mouse')

-- rebind OmniFocus ^⌥SPACE to AppleScript to launch OmniFocus if it is not already active
hs.hotkey.bind({'ctrl', 'alt'}, 'SPACE', function () hs.execute ('osascript /Users/manthei/Dropbox/AppleScripts/OmniFocus/OopsieFocus.scpt') end)

-- USB events

local volumeBeep = hs.sound.getByName('Pop')
local volumeText
local volumeTextTimer

function hideVolumeText()
    if volumeText then
        volumeText:hide(0.1)
    end
end

-- hattip https://www.snip2code.com/Snippet/1378996/A-hammerspoon-snippet-that-lets-you-hype/
hs.eventtap.new({hs.eventtap.event.types.scrollWheel}, function(e)
    local mods = hs.eventtap.checkKeyboardModifiers()
    if mods.alt and mods.ctrl and mods.shift then
        delta = e:getProperty(
            hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)
        hs.audiodevice.defaultOutputDevice():setVolume(
            hs.audiodevice.defaultOutputDevice():volume() - delta
        )
        local newVolume =
            math.floor(hs.audiodevice.defaultOutputDevice():volume())
        local speakerEmoji
        if newVolume > 60 then
            speakerEmoji = '🔊'
        elseif newVolume > 40 then
            speakerEmoji = '🔉'
        elseif newVolume > 0 then
            speakerEmoji = '🔈'
        else
            speakerEmoji = '🔇'
        end
        if not volumeText then
            volumeRect = hs.geometry.rect(20, 35, 200, 200)
            volumeText = hs.drawing.text(volumeRect, '')
            volumeText:setLevel(hs.drawing.windowLevels.cursor + 1)
            volumeText:setTextColor({1, 1, 1, 1})
        end
        volumeText:setText(speakerEmoji .. ' ' .. tostring(newVolume) .. '%')
        volumeText:show()
        if not volumeTextTimer then
            volumeTextTimer = hs.timer.delayed.new(1, hideVolumeText)
        end
        volumeTextTimer:start()
        return true
    end
end):start()

-- hs.hotkey.bind(mashshift, 'space', hs.spotify.displayCurrentTrack)
-- hs.hotkey.bind(mashshift, 'P',     hs.spotify.play)
-- hs.hotkey.bind(mashshift, 'O',     hs.spotify.pause)
-- hs.hotkey.bind(mashshift, 'N',     hs.spotify.next)
-- hs.hotkey.bind(mashshift, 'I',     hs.spotify.previous)

-- Remap media keys to Spotify-priority equivalents
-- hs.hotkey.bind({}, "f7", function()
--   hs.spotify.previous()
-- end)

-- hs.hotkey.bind({}, "f8", function()
--   hs.spotify.playpause()
-- end)

-- hs.hotkey.bind({}, "f9", function()
--   hs.spotify.next()
-- end)

-- hs.hotkey.bind({}, "f11", function()
--   playing = hs.spotify.isPlaying()

--   if playing then
--     hs.spotify.volumeDown()
--   else
--     output = hs.audiodevice.defaultOutputDevice()
--     output:setVolume(output:volume() - 10)
--   end
-- end)

-- hs.hotkey.bind({}, "f12", function()
--   playing = hs.spotify.isPlaying()

--   if playing then
--     hs.spotify.volumeUp()
--   else
--     output = hs.audiodevice.defaultOutputDevice()
--     output:setVolume(output:volume() + 10)
--   end
-- end)


-- hs.hotkey.bind({}, "f10", function() hs.alert("pressed f10") end)
-- hs.hotkey.bind({}, "f11", function() hs.alert("pressed f11") end) -- doesn't work
-- hs.hotkey.bind({}, "f12", function() hs.alert("pressed f12") end)
-- hs.hotkey.bind({}, "f13", function() hs.alert("pressed f13") end)

-- local alert_sound = hs.sound.getByFile("alert.wav")
local alert_sound  = hs.sound.getByName("Tink")
alert_sound:play()

hs.alert.show("Hammerspoon, at your service.", 2)