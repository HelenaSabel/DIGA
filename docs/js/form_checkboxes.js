
function checkboxes() {
    var inputs = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('change', changeCriteria, false);
    }
}

function changeCriteria() {
    
    var id = this.getAttribute('value');
    var marks = document.getElementsByClassName('mark');
    var corrs = document.getElementsByClassName('corr');
    var notes = document.getElementsByClassName('marginalia');
    var reclames = document.getElementsByClassName('cod');
    var handbs = document.querySelectorAll("[data-hand='b'], [data-hand='α']");
    var handcols = document.querySelectorAll("[data-hand='colocci'], [data-hand='correcteur']");
    var tardives = document.querySelectorAll("[data-hand='tardive']");
    var reviseurs = document.querySelectorAll("[data-hand='reviseur']");
    var rubricateurs = document.querySelectorAll("[data-hand='rubricateur']");
    
    switch (id) {
        case 'corr':
        
        if (this.checked == false) { for (var i = 0; i < corrs.length; i++) {
                corrs[i].classList.add('none');
            }
        } else { for (var i = 0; i < marks.length; i++) {
                corrs[i].classList.add('none');
            }
        }
        
        break;
        
        
        
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
        
        case 'correcteur':
        
        if (this.checked == true) {
            
            for (var i = 0; i < handcols.length; i++) {
                handcols[i].style.color = 'darkolivegreen';
            }
        } else { for (var i = 0; i < handcols.length; i++) {
                handcols[i].style.color = 'initial';
            }
        }
        
        break;
        
        case 'tardive':
        
        if (this.checked == true) {
            
            for (var i = 0; i < tardives.length; i++) {
                tardives[i].style.color = 'coral';
            }
        } else { for (var i = 0; i < tardives.length; i++) {
                tardives[i].style.color = 'initial';
            }
        }
        
        break;
        
        case 'reviseur':
        
        if (this.checked == true) {
            
            for (var i = 0; i < reviseurs.length; i++) {
                reviseurs[i].style.color = 'mediumturquoise';
            }
        } else { for (var i = 0; i < reviseurs.length; i++) {
                reviseurs[i].style.color = 'initial';
            }
        }
        
        break;
        
        case 'rubricateur':
        
        if (this.checked == true) {
            
            for (var i = 0; i < rubricateurs.length; i++) {
                rubricateurs[i].classList.remove("black");
            }
        } else { for (var i = 0; i < rubricateurs.length; i++) {
                rubricateurs[i].classList.add("black");
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