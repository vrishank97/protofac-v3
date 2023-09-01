"use client";
import Image from "next/image";
import { styled } from "styled-components";
import Accordion from "@mui/material/Accordion";
import AccordionSummary from "@mui/material/AccordionSummary";
import AccordionDetails from "@mui/material/AccordionDetails";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
// import Slider from '@mui/material-next/Slider';

const MainPage = styled.div`
  background-color: #a9ccff;
  padding-left: 7rem;
  padding-right: 7rem;
  padding-top: 2.5rem;
  display: flex;
  flex-direction: column;
  /* align-items: center; */
  min-height: 100vh;
`;

const Container1 = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

const WorkflButton = styled.div`
  background-color: #1c69ff;
  color: #fff;
  border-radius: 1rem;
  padding: 0.75rem 2.5rem;
  cursor: pointer;
  font-family: Nunito;
  font-size: 1rem;
`;

const Container2 = styled.div`
  padding: 3rem 10rem;
  background-color: #fff;
`;

const Division = styled.div`
  display: flex;
  flex-direction: column;
  align-items: flex-start;
`;

const WorkflowText = styled.div`
  color: #000;
  font-family: Nunito;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 700;
  line-height: normal;
`;

const NormalText = styled.div`
  color: #000;
  font-family: Nunito;
  font-size: 1rem;
  font-style: normal;
  font-weight: 400;
  line-height: normal;
`;

const GridContainer = styled.div`
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 0.125rem;
`;

const GridCell = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 5rem;
  background-color: #efefef;
  padding: 1rem;
`;

export default function Home() {
  return (
    <MainPage>
      <Container1>
        <img src="./ProtoFaclogo.svg" alt="" style={{width: "10rem"}} />
        <WorkflButton>Create your own Workflow</WorkflButton>
      </Container1>
      <div
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
        }}
      >
        <img src="./Industry.svg" alt="" style={{width: "40rem"}} />
      </div>
      <Container2>
        <Division>
          <WorkflowText>Workflows: Creating UI for Protofac</WorkflowText>
          <br />
          <NormalText>Creator: Roman Rajeev</NormalText>
          <br />
          <br />
          <div
            style={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "space-between",
              alignItems: "flex-start",
              width: "100%",
            }}
          >
            <img
              src="./CompletedClock.svg"
              style={{ width: "3.5rem" }}
              alt=""
            />
            <Accordion style={{ width: "55rem", border: "1px solid black" }}>
              <AccordionSummary
                expandIcon={<ExpandMoreIcon />}
                aria-controls="panel1a-content"
                id="panel1a-header"
              >
                <div style={{ display: "flex", flexDirection: "column" }}>
                  <WorkflowText>Task 1</WorkflowText>
                  <NormalText>Last Updated on 12th December 2023</NormalText>
                  <br />
                  <WorkflowText>Manufacture 20 T shirts</WorkflowText>
                </div>
              </AccordionSummary>
              <AccordionDetails>
                <GridContainer>
                  <GridCell>
                    <WorkflowText>Expected Start Date</WorkflowText>
                    <div>--/--/----</div>
                  </GridCell>
                  <GridCell>
                    <WorkflowText>Expected End Date</WorkflowText>
                    <div>--/--/----</div>
                  </GridCell>
                  <GridCell>
                    <WorkflowText>Actual Start Date</WorkflowText>
                    <div>--/--/----</div>
                  </GridCell>
                  <GridCell>
                    <WorkflowText>Actual End Date</WorkflowText>
                    <div>--/--/----</div>
                  </GridCell>
                </GridContainer>
                <br />
                <div
                  style={{
                    display: "flex",
                    justifyContent: "space-between",
                    width: "100%",
                  }}
                >
                  <WorkflowText>Completion Status</WorkflowText>
                  <WorkflowText>0/100 units</WorkflowText>
                </div>
              </AccordionDetails>
            </Accordion>
          </div>
        </Division>
      </Container2>
    </MainPage>
  );
}
