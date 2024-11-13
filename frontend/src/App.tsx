import { useState, useEffect } from 'react';
import './App.css';
import Spell from './types/Spell';
import Color from './types/Color';
import Modal from 'react-modal';
import axios from 'axios';

const validColors: Color[] = ["red", "blue", "green", "yellow", "purple", "orange", "black", "white", "brown", "pink"];

export const App = () => {

  const [modalOpen, setModalOpen] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(false);
  const [spells, setSpells] = useState<Spell[]>([]);
  const [spellName, setSpellName] = useState<string>('');
  const [color, setColor] = useState<Color | ''>('');

  const submitForm = () => {
    if (!spellName) {
      alert("Please enter a spell name");
      return;
    }
    if (!color) {
      alert("Please select a color");
      return;
    }
    postSpell(spellName, color).then((res) => {
      setSpells([...spells, { spellId: res.split(" ")[1], spellName, color }]);
      setModalOpen(false);
      setSpellName('');
      setColor('');
    }).catch((error) => {
      console.error("Error posting spell: ", error);
      setModalOpen(false);
      alert('Error posting spell - spell was not posted');
    });
  };

  const getSpells = async () => {
    try {
      const response = await axios.get(`${process.env.REACT_APP_API_URL}/spell`);
      setSpells(response.data);
    } catch (error) {
      console.error(error);
    }
  };

  const postSpell = async (spellName: string, color: Color) => {
    const spell = {
      spellName,
      color
    };
    const response = await axios.post(`${process.env.REACT_APP_API_URL}/spell`, spell);
    setSpells(response.data);
    return response.data;
  };

  useEffect(() => {
    setLoading(true);
    axios.defaults.headers.common['x-api-key'] = `${process.env.REACT_APP_AWS_API_KEY}`;
    getSpells().finally(() => setLoading(false));
  }, []);

  return (
    <div className="App">
      <header>
        <h1>Harry Potter Spell Catologue</h1>
        <div className='rightColumn'>
          <a href="https://github.com/jkorn8/evt-challenge" target="_blank" rel="noopener noreferrer">
            <img src='githubLogo.png' alt='Github' height='40vh' />
          </a>
        </div>
      </header>
      <div className="content">
        <h2>Full list of spells:</h2>
        {loading ? <h2>Loading...</h2> : <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Spell Name</th>
              <th>Color</th>
              {/* <th></th> */}
            </tr>
          </thead>
          <tbody>
            {spells.map(({ spellId, spellName, color }) => (
              <tr key={spellId}>
                <td>{spellId}</td>
                <td>{spellName}</td>
                <td style={{ color: color }}>{color}</td>
                {/* <td><button>Delete</button></td> */}
              </tr>
            ))}
          </tbody>
        </table>}
        <div className="centerContent">
          <button style={{ width: "20%" }} onClick={() => setModalOpen(true)}> + Add Spell </button>
        </div>
        <Modal
          isOpen={modalOpen}
          onRequestClose={() => setModalOpen(false)}
          style={{
            content: {
              top: '50%',
              left: '50%',
              right: 'auto',
              bottom: 'auto',
              marginRight: '-50%',
              transform: 'translate(-50%, -50%)',
            }
          }}
          contentLabel="Example Modal"
          ariaHideApp={false}
        >
          <div style={{ width: "100%", display: 'flex', flexDirection: 'row' }}>
            <h2 style={{ width: "70%" }}>Create New Spell</h2>
            <div className='rightColumn'>
              <button onClick={() => setModalOpen(false)}>Close</button>
            </div>
          </div>
          <div
            style={{ display: 'flex', flexDirection: 'column' }}
            onSubmit={() => submitForm()}>
            <input placeholder='Enter a Spell Name...' type='text' value={spellName} onChange={(e) => setSpellName(e.target.value)} />
            <select value={color} onChange={(e) => setColor(e.target.value as Color)}>
              <option value='' disabled>Select a Color</option>
              {validColors.map((color) => (
                <option key={color} value={color}>{color}</option>
              ))}
            </select>
            <button onClick={() => submitForm()} >Add Spell!</button>
          </div>
        </Modal>
      </div>
    </div>
  );
}

export default App;
