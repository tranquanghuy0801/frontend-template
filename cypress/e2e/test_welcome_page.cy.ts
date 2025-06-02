describe('Welcome page', () => {
  it('should display the welcome page', () => {
    cy.visit('http://localhost:5173');
    cy.contains('Welcome to Mantine');
  });
});
