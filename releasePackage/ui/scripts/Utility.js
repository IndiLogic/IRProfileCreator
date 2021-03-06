
.pragma library

function compareVersions(v1, comparator, v2) {

    var comparator = comparator == '=' ? '==' : comparator;
    if(['==','===','<','<=','>','>=','!=','!=='].indexOf(comparator) == -1) {
        throw new Error('Invalid comparator. ' + comparator);
    }
    var v1parts = v1.split('.'), v2parts = v2.split('.');
    var maxLen = Math.max(v1parts.length, v2parts.length);
    var part1, part2;
    var cmp = 0;
    for(var i = 0; i < maxLen && !cmp; i++) {
        part1 = parseInt(v1parts[i], 10) || 0;
        part2 = parseInt(v2parts[i], 10) || 0;
        if(part1 < part2)
            cmp = 1;
        if(part1 > part2)
            cmp = -1;
    }
    return eval('0' + comparator + cmp);
}

function getClenPath(filename)
{
    var path = filename;
    // remove prefixed "file:///"
    path= path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
    // unescape html codes like '%23' for '#'
    return decodeURIComponent(path);
}
