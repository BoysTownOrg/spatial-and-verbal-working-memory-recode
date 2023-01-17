#[derive(Debug, PartialEq)]
struct Event {
    time_microseconds: i32,
    trigger_code: i32,
}

fn parse(input: &str) -> Vec<Event> {
    input
        .lines()
        .skip(1)
        .map(|line| {
            let split = line.split_whitespace().collect::<Vec<_>>();
            let time_microseconds = split[0].parse::<i32>().unwrap();
            let trigger_code = split[2].parse::<i32>().unwrap();
            Event {
                time_microseconds,
                trigger_code,
            }
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn tbd() {
        let events = parse(
            "Tmu         	Code	TriNo	Comnt	Ver-C
9689000        	1	20	FIFF Trigger: 20                        
11241000       	1	24	FIFF Trigger: 24                        
11255000       	1	4096	FIFF Trigger: 4096                      
12743000       	1	4121	FIFF Trigger: 4121                      
15245000       	1	34	FIFF Trigger: 34                        
15257000       	1	4130	FIFF Trigger: 4130                      
15885000       	1	512	FIFF Trigger: 512                       
16548000       	1	4116	FIFF Trigger: 4116                      
18301000       	1	23	FIFF Trigger: 23                        ",
        );
        assert_eq!(
            events,
            vec![
                Event {
                    time_microseconds: 9689000,
                    trigger_code: 20
                },
                Event {
                    time_microseconds: 11241000,
                    trigger_code: 24
                },
                Event {
                    time_microseconds: 11255000,
                    trigger_code: 4096
                },
                Event {
                    time_microseconds: 12743000,
                    trigger_code: 4121
                },
                Event {
                    time_microseconds: 15245000,
                    trigger_code: 34
                },
                Event {
                    time_microseconds: 15257000,
                    trigger_code: 4130
                },
                Event {
                    time_microseconds: 15885000,
                    trigger_code: 512
                },
                Event {
                    time_microseconds: 16548000,
                    trigger_code: 4116
                },
                Event {
                    time_microseconds: 18301000,
                    trigger_code: 23
                }
            ]
        );
    }
}
