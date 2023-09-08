/* eslint-disable react/jsx-key */
/* eslint-disable @next/next/no-img-element */
import styled from 'styled-components'
import Accordion from "@mui/material/Accordion";
import AccordionSummary from "@mui/material/AccordionSummary";
import AccordionDetails from "@mui/material/AccordionDetails";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import { useEffect, useState } from "react";
import { db } from '@/firebaseconfig';
import { DocumentData, collection, getDocs } from 'firebase/firestore';

const MainPage = styled.div`
  background-color: #a9ccff;
  padding-left: 7rem;
  padding-right: 7rem;
  padding-top: 2.5rem;
  display: flex;
  flex-direction: column;
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
  margin-bottom: 2rem;
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

  const [tasks, setTasks] = useState<DocumentData[]>([]);

  useEffect(() => {
    const fetchTasks = async () => {
      try {
        const taskCollection = collection(db, "projects/XTfV6z3RrGMQ6AHxpu33/tasks");
        const taskSnapshot = await getDocs(taskCollection);
        const taskData = taskSnapshot.docs.map((doc) => doc.data());
        setTasks(taskData);
        console.log("Tasks:", taskData);
      } catch (error) {
        console.error("Error fetching tasks:", error);
      }
    };
    fetchTasks();
  }, []);

  const formatFirestoreTimestamp = (timestamp: { seconds: number; }) => {
    const date = new Date(timestamp.seconds * 1000); // Convert seconds to milliseconds
    const options: Intl.DateTimeFormatOptions = { 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric' 
    };
    return date.toLocaleDateString(undefined, options);
  };
  
  return (
    <MainPage>
    <Container1>
      <img src="./ProtoFaclogo.svg" alt="" style={{ width: "10rem" }} />
      <WorkflButton>Create your own Workflow</WorkflButton>
    </Container1>
    <div
      style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <img src="./Industry.svg" alt="" style={{ width: "40rem" }} />
    </div>
    <Container2>       
      {
        tasks.map((task,index) => (
          <Division>
            <WorkflowText>{task.taskName}</WorkflowText>
            <br />
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
                    <WorkflowText>Task</WorkflowText>
                    <NormalText>Last Updated on {formatFirestoreTimestamp(task.startDate)}</NormalText>
                    <br />
                    <WorkflowText>Manufacture <span>{task.targetUnits}</span>    
                       T shirts</WorkflowText>
                  </div>
                </AccordionSummary>
                <AccordionDetails>
                  <GridContainer>
                    <GridCell>
                      <WorkflowText>Expected Start Date</WorkflowText>
                      <div>
                        {formatFirestoreTimestamp(task.startDate)}
                        </div>
                    </GridCell>
                    <GridCell>
                      <WorkflowText>Expected End Date</WorkflowText>
                      <div>
                        {formatFirestoreTimestamp(task.endDate)}
                        </div>
                    </GridCell>
                    <GridCell>
                      <WorkflowText>Actual Start Date</WorkflowText>
                      <div>
                        {formatFirestoreTimestamp(task.startDate)}
                        </div>
                    </GridCell>
                    <GridCell>
                      <WorkflowText>Actual End Date</WorkflowText>
                      <div>
                        {formatFirestoreTimestamp(task.endDate)}
                        </div>
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
                    <WorkflowText>{task.completedUnits}/{task.targetUnits} units</WorkflowText>
                  </div>
                </AccordionDetails>
              </Accordion>
            </div>
          </Division>
        ))
      }
         
    </Container2>
  </MainPage>
  )
}
