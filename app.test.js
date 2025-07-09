const request = require('supertest');
const app = require('./app');

describe('App Tests', () => {
  test('GET / should return hello message', async () => {
    const response = await request(app).get('/');
    expect(response.status).toBe(200);
    expect(response.body.message).toBe('Hello DevOps World!');
    expect(response.body.version).toBe('1.0.0');
    expect(response.body.timestamp).toBeDefined();
  });

  test('GET /health should return healthy status', async () => {
    const response = await request(app).get('/health');
    expect(response.status).toBe(200);
    expect(response.body.status).toBe('healthy');
  });
});
