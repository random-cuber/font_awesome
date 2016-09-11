<?php

class font_awesome extends rcube_plugin {
    
    function init() {
        $rc = rcube::get_instance();
        if ($rc->output->type == 'html') {
            $this->include_stylesheet('assets/css/font-awesome.css');
        }
    }
    
}

?>
