pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "./modules/"

ShellRoot {
    id: root

    Loader {
        active: true
        sourceComponent: AppList{}
    }
}
