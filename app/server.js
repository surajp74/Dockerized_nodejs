const express = require('express');
const app = express();
app.use(express.json());

let items = [];

app.get('/', (req, res) => res.send('API is running'));

app.get('/items', (req, res) => res.json(items));
app.post('/items', (req, res) => {
  items.push(req.body);
  res.status(201).json(req.body);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on ${PORT}`));