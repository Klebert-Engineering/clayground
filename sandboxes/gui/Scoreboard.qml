// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Controls 2.5

ListView
{
    property TrainingDb resultStorage: null
    delegate: scoreEntry
    model: theScores

    ListModel { id: theScores }
    Component {
        id: scoreEntry
        Row {
           spacing: 5
           Text {text: caption; font.family: "Monospace"}
           Text {text: time; font.family: "Monospace"}
           Text {text: diff; font.family: "Monospace"}
        }
    }

    function processEntry(caption, seconds) {
        let diff = 0;
        if (resultStorage.oldResults.has(caption))
            diff = seconds - resultStorage.oldResults.get(caption);
        diff = diff.toFixed(2);
        let entry = {"caption": caption.padEnd(25, ' '),
                     "time": seconds.padEnd(5, ' '),
                     "diff": (diff >= 0 ? "+" : "") + diff};
        theScores.append(entry);
    }

    function update() {
        theScores.clear();
        let results = db.results;
        console.log("resup: " + JSON.stringify(results));
        for (let k of results.keys())
            processEntry(k, results.get(k));
    }
}
