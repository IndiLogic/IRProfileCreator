.pragma library


var wizardState = {
    pageProfileCreationChoice: {
       userChoice: 0,
       pages: [
           "PageCreateNewProfile.qml",
           "PageModifyProfile.qml",
           "PageDuplicateProfile.qml",
           "PageExplainProfile.qml"
       ]
    },
    pageCreateNewProfile: {
       userChoice: 0,
       pages: [
           "PageCreateDefaultProfile.qml",
           "PageCreateAppProfile.qml"
       ]
    },
    pageCreateDefaultProfile: {
       profileName: "",
       profileIconPath: ""
    }
};
