import { Inter } from "next/font/google";

import StyledComponentsRegistry from "./lib/registry";

export default function RootLayout({ children }) {
  return (
    <html style={{ margin: 0 }}>
      <link rel="preconnect" href="https://fonts.googleapis.com" />
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
      <link
        href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;500;600;700;800;900&display=swap"
        rel="stylesheet"
      />
      <body style={{ margin: "0" }}>
        <StyledComponentsRegistry>{children}</StyledComponentsRegistry>
      </body>
    </html>
  );
}
