$(document).ready(function() {
    var processingInstance;
    var initialSetupInterval = 0;

    function init() {
        $(window).bind('resize', onResize);

        setup();
    }

    function setup() {
        initialSetupInterval = setInterval(function() {
            processingInstance = Processing.getInstanceById('app');

            if (processingInstance) {
                clearInterval(initialSetupInterval);
            }
        }, 13);
    }

    function onResize() {
        if (processingInstance) {
            processingInstance.onResize();
        }
    }

    init();
});