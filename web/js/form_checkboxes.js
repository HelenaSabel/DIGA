
function checkboxes() {
    var inputs = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('change', changeCriteria, false);
    }
}

function changeCriteria() {
    
    var id = this.getAttribute('value');
    var metamarks = document.getElementsByClassName('metamark');
    var notes = document.querySelectorAll('ins');
    var reclames = document.getElementsByClassName('cod');
    
    switch (id) {
        case 'metamark':
        
        if (this.checked == true) { for (var i = 0; i < metamarks.length; i++) {
                metamarks[i].classList.remove('hide');
            }
        } else { for (var i = 0; i < metamarks.length; i++) {
                metamarks[i].classList.add('hide');
            }
        }
        
        break;
        
        case 'marginalia':
        
        if (this.checked == true) {
            
            for (var i = 0; i < notes.length; i++) {
                notes[i].classList.remove('hide');
            }
        } else { for (var i = 0; i < notes.length; i++) {
                notes[i].classList.add('hide')
            }
        }
        
        break;
        
        case 'cod':
        
        if (this.checked == false) {
            
            for (var i = 0; i < reclames.length; i++) {
                reclames[i].classList.add('hide');
            }
        } else {
            for (var i = 0; i < reclames.length; i++) {
                reclames[i].classList.remove('hide');
            }
        }
    }
}

window.addEventListener('load', checkboxes, false);