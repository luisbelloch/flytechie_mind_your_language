const NATS = require('nats');
const nats = NATS.connect({ servers: ['nats://localhost:4222'] });

process.on('SIGINT', () => {
  console.log('\nClosing connections...');
  nats.flush();
  nats.close();
  process.exit();
});

const eventTypes = types = ['initiated', 'cooking', 'delivering', 'delivered'];
const randomType = () => eventTypes[Math.floor(Math.random() * eventTypes.length)];
const randomAmount = () => parseFloat((Math.random() * 100).toFixed(2));

setInterval(() => {
  const type = `pancake.${randomType()}`;
  const event = { type, amount: randomAmount() };
  console.log(event)
  nats.publish(type, JSON.stringify(event), () => {});
}, 10);
