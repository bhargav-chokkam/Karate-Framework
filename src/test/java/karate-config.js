function() {
    var project = karate.project;
    if (!project) {
        project = 'orderitems'; // a custom 'intelligent' default
    }
    if (project == 'fiat') {
        var config = {
            Type: "application/json",
            apiKey: "Lc46sSeTPy1YblXQRjYOd9426fvp7Yey3BFYKUCj",
            key: "Lc46sSeTPy1YblXQRjYOd9426fvp7Yey3BFYKUCj",
            externalRefId: "XYZ",
            id: "b78ntw5x1k"
        };
        return config;
    }
    if (project == 'orderitems') {
        var config = {
            Type: "application/json",
            key: "Lc46sSeTPy1YblXQRjYOd9426fvp7Yey3BFYKUCj",
            id: "rfmv062hul"
        };
        return config;
    }
    karate.configure('connectTimeout', 60000);
    karate.configure('readTimeout', 200000);
}