//@ pragma UseQApplication

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth
import "./modules/bar/"

ShellRoot {
    id: root

    function updateMessage(newText) {
        panel.isSpecial = newText == "false" ? false : true;
    }
    // Pipewirt Audio intergration

    property var defaultAudioSink: Pipewire.defaultAudioSink
    property int volume: defaultAudioSink && defaultAudioSink.audio
    ? Math.round(defaultAudioSink.audio.volume * 100) 
    : 0
    property bool volumeMuted: defaultAudioSink && defaultAudioSink.audio 
    ? defaultAudioSink.audio.muted
    : false /// NOTE: i'll do it true


    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Loader {
        active: true
        sourceComponent: Bar{
            volume: root.volume
            volumeMuted: root.volumeMuted
            defaultAudioSink: root.defaultAudioSink
        }
    }
}

