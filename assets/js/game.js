import 'bulma/css/bulma.css'
import React, { useState } from 'react';
import { ch_push, ch_reset } from './socket';

function guess(text){
    if(text.length < 4) {
        return;
    }
    ch_push({guess: text});
}

export function isGameOver() {

}

export function GuessInput({enabled}) {
    const [text, setText] = useState("");

    function updateText(event) {
        let checked = "";
        for (let c of event.target.value) {
            if (checked.length < 4 && !checked.includes(c)
                && c >= '0' && c <= '9') {
                checked += c;
            }
        }
        setText(checked);
    }

    function onKeypress(event) {
        if(event.key === "Enter" && text.length === 4){
            guess(text);
        }
    }

    return (
        <div className="field has-addons has-addons-centered">
            <div className="control">
                <input className="input"
                    type="text" 
                    placeholder="Guess"
                    onChange={updateText}
                    onKeyPress={onKeypress}
                    disabled={!enabled}
                    value={text}/>
            </div>
            <div className="control">
                <button className="button is-primary"
                        disabled={!enabled || text.length !== 4}
                        onClick={() => { guess(text); }}>
                    Guess 
                </button>
            </div>
            <div className="control">
                <button className="button is-danger"
                    onClick={() => ch_reset({})}>
                    Reset
                </button>
            </div>
        </div>
    );
}
