// Simple Vercel serverless function: returns mock realtime stats.
// Works out-of-the-box on Vercel at /api/stats

module.exports = (req, res) => {
  const now = new Date().toISOString();

  const totalWealthNumber = Math.floor(500000 + Math.random() * 2000000);
  const total_wealth = '₹ ' + totalWealthNumber.toLocaleString('en-IN');

  const secure_lives = Math.floor(1000 + Math.random() * 90000);
  const active_nodes = Math.floor(5000 + Math.random() * 25000);

  const payload = {
    total_wealth,
    secure_lives,
    active_nodes,
    updated_at: now,
    source: 'serverless-mock'
  };

  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');
  return res.status(200).json(payload);
};