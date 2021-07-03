
function checkboxes() {
    var inputs = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('change', changeCriteria, false);
    }
}

function changeCriteria() {
    
    var id = this.getAttribute('value');
    var marks = document.getElementsByClassName('mark');
    var notes = document.querySelectorAll('ins');
    var reclames = document.getElementsByClassName('cod');
    var handbs = document.querySelectorAll("[data-hand='b']");
    var handcols = document.querySelectorAll("[data-hand='colocci']");
    
    switch (id) {
        case 'mark':
        
        if (this.checked == true) { for (var i = 0; i < marks.length; i++) {
                marks[i].classList.remove('hide');
            }
        } else { for (var i = 0; i < marks.length; i++) {
                marks[i].classList.add('hide');
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
        
        case 'b':
        
        if (this.checked == true) {
            
            for (var i = 0; i < handbs.length; i++) {
                handbs[i].style.color = 'darkmagenta';
            }
        } else { for (var i = 0; i < handbs.length; i++) {
                handbs[i].style.color = 'initial';
            }
        }
        
        break;
        
        case 'colocci':
        
        if (this.checked == true) {
            
            for (var i = 0; i < handcols.length; i++) {
                handcols[i].style.color = 'darkolivegreen';
            }
        } else { for (var i = 0; i < handcols.length; i++) {
                handcols[i].style.color = 'initial';
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