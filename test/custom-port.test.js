import {expect, test} from "vitest";

// Try to connect to a custom port on Graph node
test("Connect to custom port", async () => {
    // Test if the server is running on the custom port
    const url = "http://localhost:1234";
    const response = await fetch(url);
    expect(response.status).toBe(200);
});

test("Connect to custom admin port", async () => {
    // Test if the server is running on the custom port
    const url = "http://localhost:4321";
    const response = await fetch(url);
    expect(response.status).toBe(200);
});
