/**
 * Company: Eureka²
 * Developer: Stefano Graziato
 * Email: stefano.graziato@eurekaa.it
 * Homepage: http://www.eurekaa.it
 * GitHub: https://github.com/eurekaa

 * File Name: jquery.namespace
 * Created: 05/09/13 19.25
 */

jQuery.extend({

    namespace: function (spaces) {
        var parent_space = window;
        var namespaces = spaces.split(".");

        for (var i = 0; i < namespaces.length; i++) {
            if (typeof parent_space[namespaces[i]] == "undefined") {
                parent_space[namespaces[i]] = {};
            }

            parent_space = parent_space[namespaces[i]];
        }

        return parent_space;
    }

});
